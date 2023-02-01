--Безпосердньо стоврення поцедури
create proc spProdCount
	@pCatName nvarchar (50) = null
	, @pProdCount int output
as
begin
	if @pCatName is null
	begin
		return 100
	end

	declare @vCatCnt int = 0

	SET @pCatName = '%' + @pCatName + '%'
	SET @vCatCnt = (select count (*) 
				from Categories 
				where CategoryName like @pCatName)

	IF @vCatCnt = 0 begin return 1 end
	else if @vCatCnt>1 begin return 2 end
	else 
		begin
			set @pProdCount = 
				(select  count(*)
				from Products P
				where exists (
					select * from Categories C
					Where C.CategoryName like @pCatName
						and P.CategoryID = C.CategoryID)
				)
			return 0
		end 
end

--Тестування процедури (+ обробка кодів повернення)
declare @RC int
	, @vCatName  nvarchar (50) = 'bev' -- set Category name here
	, @vProdCnt int

exec @RC=spProdCount
					@pCatName =  @vCatName
					,@pProdCount = @vProdCnt output

--PRINT '@vProdCnt after procedure ' + CAST(@vProdCnt as nvarchar (50))
--PRINT '@RC after procedure ' + CAST(@RC as nvarchar (50))

--Обробка кодів (просто варіант як використовуються коди повернення. Не робили на уроці)
--тут я не використовува БЕГІН/ЕНД
IF @RC = 0  
BEGIN  
    PRINT 'Status: OK';
	PRINT 'Prod count: ' + CAST (@vProdCnt as nvarchar)
END  
ELSE IF @RC = 1  
    PRINT 'Status: ERROR. No category found.'
ELSE IF @RC = 2   
    PRINT 'Status: ERROR. To many categories.'
ELSE IF @RC = 100
    PRINT 'Status: ERROR. Specify category name.'
