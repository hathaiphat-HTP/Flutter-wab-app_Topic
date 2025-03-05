# Pantip Topic System

## Overview
โปรเจคนี้เป็นระบบการจัดการกระทู้ที่ใช้ Firebase Cloud Firestore ในการเก็บข้อมูล โดยมีการเพิ่มฟิลด์สำหรับการสร้างกระทู้ใหม่ แก้ไขกระทู้ และแสดงรายการกระทู้ที่สร้าง ระบบนี้มีลักษณะการทำงานคล้ายกับการสร้างกระทู้ในเว็บไซต์ Pantip

## Features
- ลงชื่อเข้าใช้งานและลงทะเบียนผู้ใช้ใหม่
- สร้างกระทู้ใหม่พร้อมรายละเอียดและแฮชแท็ก
- แก้ไขกระทู้ที่มีอยู่
- ลบกระทู้ที่มีอยู่
- แสดงรายการกระทู้ทั้งหมดที่สร้าง

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/yourrepository.git
   
2. Navigate to the project directory:
   cd yourrepository
   
4. Install dependencies:
   flutter pub get

### Firebase Setup
1. ไปที่ Firebase Console
2. สร้างโปรเจคใหม่หรือเลือกโปรเจคที่มีอยู่
3. เพิ่มแอป Flutter ของคุณใน Firebase และดาวน์โหลดไฟล์ google-services.json (สำหรับ Android) และ/หรือ GoogleService-Info.plist (สำหรับ iOS)
4. วางไฟล์เหล่านี้ในโฟลเดอร์ที่เหมาะสมในโปรเจคของคุณ
   
### Usage
- เปิดแอปและทำการลงทะเบียนหรือเข้าสู่ระบบ
- สร้างกระทู้ใหม่โดยกรอกข้อมูลหัวข้อ รายละเอียด และแฮชแท็ก
- แก้ไขหรือลบกระทู้ที่มีอยู่ตามต้องการ
- แสดงรายการกระทู้ทั้งหมดที่สร้าง

## Getting Started
### Prerequisites
- Flutter SDK
- Firebase account
  
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
