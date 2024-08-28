-- CreateEnum
CREATE TYPE "Status" AS ENUM ('ACTIVE', 'INACTIVE');

-- CreateEnum
CREATE TYPE "PrompType" AS ENUM ('PROMPT_1', 'PROMPT_2', 'PROMPT_3', 'PROMPT_4');

-- CreateEnum
CREATE TYPE "InputType" AS ENUM ('FROM_Message', 'FROM_Manual');

-- CreateEnum
CREATE TYPE "Category" AS ENUM ('RETAURANT', 'SHOPPING', 'ENTERTAINMENT', 'TRANSPORTATION', 'HEALTH', 'EDUCATION', 'OTHER');

-- CreateTable
CREATE TABLE "IncomeMoney" (
    "id" UUID NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "MessageInputId" UUID,
    "inputType" "InputType" NOT NULL DEFAULT 'FROM_Message',
    "spendingDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "category" "Category" NOT NULL,
    "status" "Status" NOT NULL DEFAULT 'ACTIVE',
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "updatedBy" TEXT,
    "deletedAt" TIMESTAMP(3),
    "deletedBy" TEXT,

    CONSTRAINT "IncomeMoney_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MessageInput" (
    "id" UUID NOT NULL,
    "message" TEXT NOT NULL,
    "sourceIncomeId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "updatedBy" TEXT,
    "deletedAt" TIMESTAMP(3),
    "deletedBy" TEXT,

    CONSTRAINT "MessageInput_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MessageOutput" (
    "id" UUID NOT NULL,
    "message" TEXT NOT NULL,
    "messageInputId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "updatedBy" TEXT,
    "deletedAt" TIMESTAMP(3),
    "deletedBy" TEXT,

    CONSTRAINT "MessageOutput_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SourceIncome" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "updatedBy" TEXT,
    "deletedAt" TIMESTAMP(3),
    "deletedBy" TEXT,

    CONSTRAINT "SourceIncome_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Prompt" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "PrompType" "PrompType" NOT NULL,
    "Regex" TEXT,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "updatedBy" TEXT,
    "deletedAt" TIMESTAMP(3),
    "deletedBy" TEXT,

    CONSTRAINT "Prompt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SourcePromtHandler" (
    "promptId" UUID NOT NULL,
    "sourceIncomeId" UUID NOT NULL,

    CONSTRAINT "SourcePromtHandler_pkey" PRIMARY KEY ("promptId","sourceIncomeId")
);

-- CreateTable
CREATE TABLE "User" (
    "id" UUID NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "firstname" TEXT,
    "lastname" TEXT,
    "roleId" UUID,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" TEXT,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "updatedBy" TEXT,
    "deletedAt" TIMESTAMP(3),
    "deletedBy" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Role" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" TEXT,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "updatedBy" TEXT,
    "deletedAt" TIMESTAMP(3),
    "deletedBy" TEXT,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Permission" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" TEXT,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "updatedBy" TEXT,
    "deletedAt" TIMESTAMP(3),
    "deletedBy" TEXT,

    CONSTRAINT "Permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Function" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "customName" TEXT,
    "description" TEXT,
    "link" TEXT,
    "status" "Status" NOT NULL DEFAULT 'ACTIVE',
    "parentId" UUID,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" TEXT,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "updatedBy" TEXT,
    "deletedAt" TIMESTAMP(3),
    "deletedBy" TEXT,

    CONSTRAINT "Function_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RolePermission" (
    "roleId" UUID NOT NULL,
    "permissionId" UUID NOT NULL,

    CONSTRAINT "RolePermission_pkey" PRIMARY KEY ("roleId","permissionId")
);

-- CreateTable
CREATE TABLE "PermissionFunction" (
    "permissionId" UUID NOT NULL,
    "functionId" UUID NOT NULL,

    CONSTRAINT "PermissionFunction_pkey" PRIMARY KEY ("permissionId","functionId")
);

-- CreateIndex
CREATE UNIQUE INDEX "SourceIncome_name_key" ON "SourceIncome"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Prompt_name_key" ON "Prompt"("name");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Role_name_key" ON "Role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Permission_name_key" ON "Permission"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Function_name_key" ON "Function"("name");

-- AddForeignKey
ALTER TABLE "IncomeMoney" ADD CONSTRAINT "IncomeMoney_MessageInputId_fkey" FOREIGN KEY ("MessageInputId") REFERENCES "MessageInput"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IncomeMoney" ADD CONSTRAINT "IncomeMoney_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MessageInput" ADD CONSTRAINT "MessageInput_sourceIncomeId_fkey" FOREIGN KEY ("sourceIncomeId") REFERENCES "SourceIncome"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MessageInput" ADD CONSTRAINT "MessageInput_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MessageOutput" ADD CONSTRAINT "MessageOutput_messageInputId_fkey" FOREIGN KEY ("messageInputId") REFERENCES "MessageInput"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MessageOutput" ADD CONSTRAINT "MessageOutput_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SourceIncome" ADD CONSTRAINT "SourceIncome_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Prompt" ADD CONSTRAINT "Prompt_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SourcePromtHandler" ADD CONSTRAINT "SourcePromtHandler_promptId_fkey" FOREIGN KEY ("promptId") REFERENCES "Prompt"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SourcePromtHandler" ADD CONSTRAINT "SourcePromtHandler_sourceIncomeId_fkey" FOREIGN KEY ("sourceIncomeId") REFERENCES "SourceIncome"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Function" ADD CONSTRAINT "Function_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Function"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "RolePermission" ADD CONSTRAINT "RolePermission_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RolePermission" ADD CONSTRAINT "RolePermission_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES "Permission"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PermissionFunction" ADD CONSTRAINT "PermissionFunction_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES "Permission"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PermissionFunction" ADD CONSTRAINT "PermissionFunction_functionId_fkey" FOREIGN KEY ("functionId") REFERENCES "Function"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
