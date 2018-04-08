
--Lua基本语法
--17.1 类型与值
--Lua中变量没有类型，值才有类型
--Lua中类型  nil 、boolean、number、string、table、function、userdata、thread
--Lua中进行判断，除了false和nil为假外，其他任何值都为真
--查看一个值的类型
local str = "Hello world"
local sType = type(str)
print ("Hello " .. tostring(sType))
--Lua中字符串和数字是可以相互转换的，tostring()可以将数字转换为字符串，tonumber()可以将数字转换为字符串
--Lua中所有的变量默认为全局变量，在变量名前加local可以定义为局部变量
--注释，单行 -- 多行 --[[  ]]

--17.2操作符
--算数操作符  + - * / ^ 取幂 - 取反
--关系操作符 < > <= >= == ~=  注意:字符串与数字并不相等 e.g "0" == 0 返回false
--table  userdata function 等类型的值，只有当两者为同一对象是相等
--逻辑操作符 and or not 
--一个技巧：当一个变量为nil或false时，可以使用or来快速进行判断并赋值。e.g a = a or b
--其他操作符
--[[. 访问table  
	: 访问table的字段并传入该table
	, 分隔表达式
	.. 对字符串（将数字作为字符串）进行连接 
	[] 访问table下标
	#  获取table的长度（从1开始到nil）
	=  赋值 
]]

--17.3 语句
--赋值语句
--可以对多个变量进行同时赋值
--交换a、b的值
-- a,b = b,a

--语句块
do 
	local a = 1
	a = a + 1
	print (a)
end

--条件语句
-- if true then

-- elseif false then

-- else 

-- end 

--循环语句
-- while true do --条件为假结束
-- 	--系列语句
-- end 
--重复执行知道条件成立
-- repeat
-- 	--系列语句
-- until true --条件

--数字型for循环中，var=初始值，每次循环var增加exp3，知道var大于等于exp2时，退出循环。exp3不写默认1
--var在这里为局部变量值
-- for var=exp1,exp2,exp3 do
-- 	--循环语句
-- end

--泛型for循环中，var-list为变量列表，是表达式列表每次执行的返回值。表达式列表一般为一个函数，当表达式列表返回的第一个参数为nil时，退出循环。
-- for <var-list> in <exp-list> do
	
-- end

--使用break和return语句可以退出循环，但只能出现在语句块的最后，也就是说在end，else，until之前。
--如果需要在语句块中间使用return，break，可以使用do-end循环包裹起来

--17.4函数
--定义函数
--函数定义需要以function关键字开头，紧接着是函数名（没有则为匿名函数），再接下来是函数参数列表，以（）包裹，然后是函数体
-- function fun( ... )
-- 	-- body
-- end

--上面定义了一个fun函数，等同于创建一个函数对象，并将函数对象赋值给一个叫做fun的变量
-- fun = function ( str ) print str end  调用fun()  
--如果这时候将fun赋值给其他变量，那么其他变量也会有fun()函数对象的引用。

--调用函数
--Lua中调用函数，需要再函数名后加上括号，来传入参数，同时可以使用赋值操作符接住函数的返回值
--当调用的函数只有一个参数，并且这个参数是字符串或表构造时，无需加括号
-- e.g
print "Hello World"
print {"one","two"}

--函数参数
--函数的参数列表中，可以声明函数接受的参数。在参数列表的最后加三个点"..."，可以表示变长的参数，使用赋值语句可以将变长的参数
--列表取出，也可以将这些可变参数传递给其他函数
function fun( a, ... )
	-- body
	--取出...的3个参数
	local v1,v2,v3 = ...
	print (a .. v1 .. v2 .. v3)
end
--第一个参数会被赋值给fun的a参数
--接下来的三个参数在fun中被取出
--最后...中只剩下1个参数 --5
fun(1,2,3,4,5)

--尾调用
--当函数的最后一个动作是调用另外一个函数时，这个调用被称为尾调用。e.g return fun(...)
--因为尾调用之后程序不需要在栈中保留调用者的任何信息，所以在处理尾调用时，可以不使用额外的栈空间
--也就是说可以直接跳转到尾调用的函数中，而不是再开辟一个栈，然后调用该函数
--Lua 这种处理称为尾调用消除
-- e.g 下面的fun函数进行了递归，那么他的return fun(num)是一个尾调用，在C/C++语言中，执行到return 'over'的时候，
--会有100层的函数调用堆栈，而lua只会有一层
function fun (num, ... )
	-- body
	if num > 100 then
		return "over"
	else
		num = num + 1
		return fun(num)
	end
end

--调用fun
fun(1)

--如果将return fun(num)改为return (fun(num)) ，此时的fun就不是尾调用了，因为在执行完fun()需要回到调用者这边，执行上一层的括号。


