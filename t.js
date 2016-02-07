const zlib = require('zlib');
const msgpack = require('msgpack');
gen = () => ({
    "s": 4,
    "d": [
        [~~(Math.random() * 255), ~~(Math.random() * 255), ~~(Math.random() * 255)],
        [~~(Math.random() * 255), ~~(Math.random() * 255), ~~(Math.random() * 255)],
        [~~(Math.random() * 255), ~~(Math.random() * 255), ~~(Math.random() * 255)],

        [~~(Math.random() * 255), ~~(Math.random() * 255), ~~(Math.random() * 255)],
        [~~(Math.random() * 255), ~~(Math.random() * 255), ~~(Math.random() * 255)],
        [~~(Math.random() * 255), ~~(Math.random() * 255), ~~(Math.random() * 255)],

        [~~(Math.random() * 255), ~~(Math.random() * 255), ~~(Math.random() * 255)],
        [~~(Math.random() * 255), ~~(Math.random() * 255), ~~(Math.random() * 255)],
        [~~(Math.random() * 255), ~~(Math.random() * 255), ~~(Math.random() * 255)]
    ]
});

var count = 50000;
var totals = { json: 0, gzipJson: 0, deflateJson: 0, mp: 0, gzipMp: 0, deflateMp: 0, custom: 0, gzipcustom: 0, deflatecustom: 0, };

function genCustom(data) {
    const buffer = new Buffer(data.d.length * 3 + 1);
    buffer.writeUInt8(data.s, 0);
    for (var i = 0; i < data.d.length; i++) {
        var d = data.d[i];
        for (var k = 0; k < d.length; k++) {
            buffer.writeUInt8(d[k], i * d.length + k + 1);
        }
    }

    return buffer;
}

for (var i = 0; i < count; i++) {
    var data = gen();
    var n = JSON.stringify(data);
    totals.json += n.length;
    totals.deflateJson += zlib.deflateRawSync(n).length
    totals.gzipJson += zlib.gzipSync(new Buffer(n)).length;
    var p = msgpack.pack(data);
    totals.mp += p.length;
    totals.deflateMp += zlib.deflateRawSync(p).length
    totals.gzipMp += zlib.gzipSync(p).length;

    var c = genCustom(data);
    totals.custom += c.length;
    totals.deflatecustom += zlib.deflateRawSync(c).length
    totals.gzipcustom += zlib.gzipSync(c).length;
}

console.log('Built and marshaled ' + count + ' random pixel matricies');
console.log('==');
console.log('Bytes per message with JSON: ' + (totals.json / count));
console.log('Bytes per message with Gzipped JSON: ' + (totals.gzipJson / count));
console.log('Bytes per message with Deflate JSON: ' + (totals.deflateJson / count));
console.log('--');
console.log('Bytes per message with MessagePack: ' + (totals.mp / count));
console.log('Bytes per message with Gzipped MessagePack: ' + (totals.gzipMp / count));
console.log('Bytes per message with Deflate MessagePack: ' + (totals.deflateMp / count));
console.log('--');
console.log('Bytes per message with Custom: ' + (totals.custom / count));
console.log('Bytes per message with Gzipped Custom: ' + (totals.gzipcustom / count));
console.log('Bytes per message with Deflate Custom: ' + (totals.deflatecustom / count));
