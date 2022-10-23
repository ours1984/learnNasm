
extern int callFromC(int a,int*b);

int main()
{
    int a = 20;
    int b = 30;
    
    int c = callFromC(a,&b);

    return c*c;
}
