a = 9

x = 0.001
for i in range(20):
	print(i, x)
	x_k1 = x - (x**2 -a)/(2*x)
	x = x_k1

print('result ', x_k1)