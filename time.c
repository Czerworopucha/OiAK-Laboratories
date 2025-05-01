#include<stdio.h>
unsigned long long getCounter(unsigned int p, unsigned int quantity);
float calka();

int main()
{
	unsigned long long tstamp1, tstamp2;
	unsigned int p, quantity;
	float wynik;
	
	printf("Mode: 0 = rdtsc, 1 = rdtscp\n");
	scanf("%u", &p);
	printf("Quantity:\n");
	scanf("%u", &quantity);

	tstamp1 = getCounter(p, quantity);
	wynik = calka();
	tstamp2 = getCounter(p, quantity);
	
	printf("Wynik: %f\n", wynik);
	printf("Cycles: %llu\n", tstamp2 - tstamp1);
		
	return 0;
}