--a) Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles

declare @num int
set @num = 123
if (@num % 2 = 0)
begin
    print cast(@num as varchar) + N' é multiplo de 2'
end
if (@num % 3 = 0)
begin
    print cast(@num as varchar) + N' é multiplo de 3'
end
if (@num % 5 = 0)
begin
    print cast(@num as varchar) + N' é multiplo de 5'
end

-- b) Fazer um algoritmo que leia 3 números e mostre o maior e o menor

declare @num1 int,
        @num2 int,
        @num3 int,
        @maior int,
        @menor int,
        @meio int,
        @aux int
set @num1 = -10
set @num2 = -2
set @num3 = 1
set @maior = @num1
set @menor = @num2
set @meio = @num3
if (@menor > @maior)
begin
    set @aux = @maior
    set @maior = @menor
    set @menor = @aux
end
if (@meio > @maior)
begin
    set @aux = @maior
    set @maior = @meio
    set @meio = @aux
end
if (@meio < @menor)
begin
    set @aux = @menor
    set @menor = @meio
    set @meio = @aux
end
print cast(@menor as varchar) + ' ' + cast(@maior as varchar)

-- c) Fazer um algoritmo que calcule os 15 primeiros termos da série
-- 1,1,2,3,5,8,13,21,...
-- E calcule a soma dos 15 termos

declare @valor int,
        @cont int,
        @aux2 int,
        @soma int
set @valor = 1
set @aux2 = 1
set @cont = 1
while (@cont < 15)
begin
    set @soma= @aux2 + @valor
    set @aux2 = @valor
    set @valor = @soma
    set @cont = @cont + 1
    print @valor
end

-- d) Fazer um algoritmo que separa uma frase, colocando todas as letras em maiúsculo e em
-- minúsculo (Usar funções UPPER e LOWER)

declare @frase varchar(40)
set @frase = N'CaDastraR CLienTE'
set @frase = upper(@frase)
set @frase = lower(@frase)
print @frase

-- e) Fazer um algoritmo que inverta uma palavra (Usar a função SUBSTRING)

declare  @palavra varchar(40),
         @invertida varchar(40)
set @palavra = 'Miojo'
set @invertida = ''
while (len(@palavra) > 0)
begin
    print @invertida
    set @invertida = @invertida + substring(@palavra, len(@palavra), len(@palavra))
    set @palavra = substring(@palavra, 1, len(@palavra) - 1)
end
print @invertida

-- f) Considerando a tabela abaixo, gere uma massa de dados, com 100 registros, para fins de teste
-- com as regras estabelecidas (Não usar constraints na criação da tabela)

-- ID Marca QtdRAM TipoHD QtdHD FreqCPU
-- INT (PK) VARCHAR(40) INT VARCHAR(10) INT DECIMAL(7,2)
--
-- • ID incremental a iniciar de 10001
-- • Marca segue o padrão simples, Marca 1, Marca 2, Marca 3, etc.
-- • QtdRAM é um número aleatório* dentre os valores permitidos (2, 4, 8, 16)
-- • TipoHD segue o padrão:
-- o Se o ID dividido por 3 der resto 0, é HDD
-- o Se o ID dividido por 3 der resto 1, é SSD
-- o Se o ID dividido por 3 der resto 2, é M2 NVME
-- • QtdHD segue o padrão:
-- o Se o TipoHD for HDD, um valor aleatório* dentre os valores permitidos (500, 1000 ou 2000)
-- o Se o TipoHD for SSD, um valor aleatório* dentre os valores permitidos (128, 256, 512)
-- • FreqHD é um número aleatório* entre 1.70 e 3.20
--
-- * Função RAND() gera números aleatórios entre 0 e 0,9999...

create database computador

use computador

create table PC (
    id      int             not null ,
    marca   varchar(40)     not null ,
    qtdRam  int             not null ,
    tipoHd  varchar(10)     not null ,
    qtdHd   int             not null ,
    freqCpu decimal(7, 2)   not null ,
    primary key (id)
)

declare @id int,
        @marca varchar(40),
        @qtdRam int,
        @tipoHd varchar(10),
        @qtdHd int,
        @freqCpu decimal(7, 2),
        @cont2 int,
        @ram int
set @cont2 = 0
set @id = 10000
while (@cont2 < 100)
begin
    set @id = @id + 1

    set @marca = 'Marca ' + cast(@cont2 as varchar(4))

    set @ram = cast(rand() * 4 + 1 as int)
    if (@ram = 1)
    begin
        set @qtdRam = 2
    end
    if (@ram = 2)
    begin
        set @qtdRam = 4
    end
    if (@ram = 3)
    begin
        set @qtdRam = 8
    end
    if (@ram = 4)
    begin
       set @qtdRam = 16
    end

    if (@id % 3 = 0)
    begin
        set @tipoHd = 'HDD'
    end
    if (@id % 3 = 1)
    begin
        set @tipoHd = 'SSD'
    end
    if (@id % 3 = 2)
    begin
        set @tipoHd = 'M2 NVME'
    end

    if (@tipoHd = 'HDD')
    begin
        set @qtdHd = cast(rand() * 3 + 1 as int)
        if (@qtdHd = 1)
        begin
            set @qtdHd = 500
        end
        if (@qtdHd = 2)
        begin
            set @qtdHd = 1000
        end
        if (@qtdHd = 3)
        begin
            set @qtdHd = 2000
        end
    end
    if (@tipoHd = 'SSD' or @tipoHd = 'M2 NVME')
    begin
        set @qtdHd = cast(rand() * 3 + 1 as int)
        if (@qtdHd = 1)
        begin
            set @qtdHd = 128
        end
        if (@qtdHd = 2)
        begin
            set @qtdHd = 256
        end
        if (@qtdHd = 3)
        begin
            set @qtdHd = 512
        end
    end

    set @freqCpu = cast(rand() * 1.50 + 1.70 as decimal(7, 2))


    insert into PC values (@id, @marca, @qtdRam, @tipoHd, @qtdHd, @freqCpu)

    set @cont2 = @cont2 + 1
end

select * from PC

delete from PC

select * from PC
where freqCpu < 1.70 or freqCpu > 3.20