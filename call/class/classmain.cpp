
struct Base{
public:
    int funa(int tmp){
        return tmp+pub++;
    };

    int funb(){
        int tmp=++prot;
        return tmp;
    }
    int get(){
        return priv;
    }
public:
    int pub;
protected:
    int prot;
private:
    int priv;
};

int main()
{
    Base stack;
    stack.funa(10);
    Base* heap=new Base();
    heap->funb();
    int ret = stack.get()+heap->get();
    delete heap;
    return ret;
}
