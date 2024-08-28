Backend:
cd backend
chạy npm install -> cài package

cài docker desktop, cài xong mới làm.
docker-compose -f docker-compose.db.yml up -d -> tạo postgre
docker-compose build -> tạo docker image
docker-compose up -d -> start docker

npx prisma db push -> update schema db
npx prisma db seed -> tạo dữ liệu mẫu -> tạo user admin -> tìm file C:\Users\Thien\Documents\projects\SavvySpender\backend\prisma\seed.ts

tìm file .env để cấu hình local:
# Nest
PORT=7113 -> sửa cái port theo ý chú muốn -> tui chạy 7113 còn chú chạy cái nào cũng dc, né port 3000 ra vì nó sẽ đụng với frontend
Sửa port thì nhớ sửa luôn trong file C:\Users\Thien\Documents\projects\SavvySpender\frontend\ultis\api.ts. Nó dùng để gọi api từ backend

npm run start -> start server localhost

Frontend:

cd frontend

npm install -> cài pakage (đã bao gồm tailwind, axios, sass)
npm run dev -> start server 

Hiện tại frontend thì tui chưa làm gì cả. mới gọi api login thui nhưng nó redirect dell dc