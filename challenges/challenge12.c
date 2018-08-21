int main(void) 
{ 
        setuid(0);
        system("echo `whoami` loves Bob"); 
} 
