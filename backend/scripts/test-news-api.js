const http = require('http');

function testAPI(path) {
    return new Promise((resolve, reject) => {
        const options = {
            hostname: 'localhost',
            port: 3000,
            path: path,
            method: 'GET'
        };

        const req = http.request(options, (res) => {
            let data = '';
            res.on('data', chunk => data += chunk);
            res.on('end', () => {
                try {
                    const json = JSON.parse(data);
                    resolve(json);
                } catch {
                    resolve(data);
                }
            });
        });

        req.on('error', reject);
        req.end();
    });
}

async function main() {
    console.log('Testing /api/news endpoint...\n');
    
    try {
        const result = await testAPI('/api/news');
        console.log('Response:', JSON.stringify(result, null, 2));
    } catch (error) {
        console.log('Error:', error.message);
        console.log('\nServer có thể chưa chạy. Hãy chạy "npm start" trước.');
    }
}

main();
