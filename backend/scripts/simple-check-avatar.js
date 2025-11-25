const db = require('../config/database');
require('dotenv').config();

async function checkAvatar() {
    try {
        const [admins] = await db.query(`
            SELECT email, ten_hien_thi, anh_dai_dien 
            FROM admin 
            WHERE email LIKE '%@gmail.com'
            LIMIT 1
        `);

        if (admins.length > 0) {
            console.log('Admin Email:', admins[0].email);
            console.log('Admin Name:', admins[0].ten_hien_thi);
            console.log('Avatar URL:', admins[0].anh_dai_dien);
        } else {
            console.log('No admin found with gmail.');
        }
        process.exit(0);
    } catch (error) {
        console.error(error);
        process.exit(1);
    }
}

checkAvatar();
