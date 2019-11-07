public with sharing class FormatDemo {
public Integer number;
    public FormatDemo(Integer number) {
    this.number=number;
}

public static void doSomthing(String s){ System.debug('i did something: '+s);}

        public static void doSomethingElse(Boolean b) {
            if(b==false)System.debug('false');
            for(Integer i=0;i<4;i++){
                System.debug('hi');
            }
        }
}
