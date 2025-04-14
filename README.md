flutter_music_playlist - คู่มือการใช้งาน
📱 หน้าตาแอปพลิเคชัน
ตัวอย่างแอปพลิเคชัน (ตัวอย่างรูปภาพ)

![App Screenshot](https://i.ibb.co/WWzrk9Ct/Simulator-Screenshot-i-Phone-15-Pro-Max-2025-04-14-at-20-35-05.png)
https://ibb.co/d0pNP9Zg
https://ibb.co/WWtnmtkJ
https://ibb.co/Jj6rsJGk
https://ibb.co/HDMz58CS
📥 การติดตั้ง
โคลนโปรเจกต์:

bash
Copy
git clone https://github.com/yourusername/flutter_music_playlist.git
cd flutter_music_playlist
ติดตั้ง dependencies:

bash
Copy
flutter pub get
รันแอปพลิเคชัน:

bash
Copy
flutter run
� คุณสมบัติหลัก
✅ เล่นเพลงจาก playlist

✅ เพิ่ม/ลบเพลงจาก playlist

✅ สร้าง playlist ใหม่

✅ แสดงเนื้อเพลง (Lyrics)

🎧 ขั้นตอนการใช้งาน
1. การเล่นเพลง
เปิดแอปพลิเคชัน

เลือก playlist ที่ต้องการ

กดเพลงที่ต้องการฟัง

ใช้ปุ่มควบคุมด้านล่าง:

⏯️ เล่น/หยุดชั่วคราว

⏭️ ข้ามไปเพลงถัดไป

⏮️ กลับไปเพลงก่อนหน้า

🔉 ปรับระดับเสียง

2. การจัดการ Playlist
เพิ่มเพลงใหม่:

กดปุ่ม "+ เพิ่มเพลง" ที่มุมขวาบน

เลือกไฟล์เพลงจากอุปกรณ์

กรอกข้อมูลเพลง (ชื่อ, ศิลปิน)

กด "บันทึก"

ลบเพลง:

กดค้างที่เพลงที่ต้องการลบ

เลือก "ลบ"

ยืนยันการลบ

3. การสร้าง Playlist ใหม่
กดแท็บ "Playlist ของฉัน"

กด "+ Playlist ใหม่"

ตั้งชื่อ playlist

กด "สร้าง"

เพิ่มเพลงลงใน playlist ใหม่

⚙️ การตั้งค่า
เข้าถึงได้จากเมนูด้านข้าง:

เปลี่ยนธีม (สว่าง/มืด)

ตั้งค่าความเร็วการเล่น

ตั้งค่าคุณภาพเสียง

🆘 ปัญหาที่พบบ่อย
ปัญหา: ไม่เห็นเพลงใน playlist
แก้ไข: ตรวจสอบว่าได้เพิ่มไฟล์เพลงในโฟลเดอร์ /assets/music/ แล้วรัน flutter pub get อีกครั้ง

ปัญหา: เสียงไม่ดัง
แก้ไข: ตรวจสอบระดับเสียงทั้งในแอปและอุปกรณ์

📜 ข้อมูลเพิ่มเติม
สำหรับนักพัฒนา:

เอกสาร API

Changelog

✉️ ติดต่อผู้พัฒนา: developer@example.com
🐞 รายงานปัญหา: Issue Tracker

