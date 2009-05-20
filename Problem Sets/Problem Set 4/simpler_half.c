#include <stdio.h>

int main (int argv, char ** argc){
	unsigned int u = 7283, v = 24272, p = 65537, x, y, i, j, m, x3, y2, inverse, loop, d;
	
	for (x = 0; x < p - 1; x++){
		x3 = (x * x) % p;
		x3 = (x3 * x) %p;
		y2 = (x3 + 5 * x - 6) % p;
		
		for (y = 0; y < p - 1; y++){
			x3 = (y * y) % p;
			
			if (x3 == y2){
				for (loop = 0; loop < 2; loop++){
					if (loop == 1){y = (p - y) % p;}
					m = (x * x) % p;
					m = (3 * m + 5) %p;
					inverse = 0;
					for (d = 2; d < p; d++){
						d = d % p;
						x3 = (d * 2) % p;
						x3 = (x3 * y) %p;
						if (x3 == 1){inverse = d;break;}
					}
					m = (m * inverse)%p;
					if (inverse != 0){
						i = ((m * m) - (2 * x)) % p;
						j = 0;
						if (i == u){
							j = (m*(x + (p -u)) - y) % p;
							if (j == v){
								printf("x = %u\ty = %u\n", x, y);
							}
						}
					}
				}
				break;
			}
		}
	}
	
	return 0;
}