import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  console.log('Seeding...');

  const admin1 = await prisma.user.create({
    data: {
      email: 'nguyenxuanhoangthien92@gmail.com',
      firstname: 'Hoàng',
      lastname: 'Thiên',
      password: '$2b$10$EpRnTzVlqHNP0.fUbXUwSOyuiXe/QLSUG6xNekdHgTGmrpHEfIoxm', // secret42
    },
  });
  const admin2 = await prisma.user.create({
    data: {
      email: 'trinhhung@gmail.com',
      firstname: 'Hưng',
      lastname: 'Trịnh',
      password: '$2b$10$EpRnTzVlqHNP0.fUbXUwSOyuiXe/QLSUG6xNekdHgTGmrpHEfIoxm', // secret42
    },
  });

  console.log({ admin1, admin2 });
}

main()
  .catch((e) => console.error(e))
  .finally(async () => {
    await prisma.$disconnect();
  });
