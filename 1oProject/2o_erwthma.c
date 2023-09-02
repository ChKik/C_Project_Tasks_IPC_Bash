// Κικίδης Χαρίτων     	1084595	up1084595@upnet.gr
// Νασιέλη Βασιλική    	1090034	up1090034@upnet.gr
// Πλάτωνας Θεόδωρος   	1090073	up1090073@upnet.gr
// Σουλελέ Αναστασία   	1084612	up1084612@upnet.gr


#include <stdio.h>
#include <math.h> //prepei na valeis -lm sto telos gia na kanei to link sto math library
#include <sys/time.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <sys/types.h>
#include <time.h>
#include <sys/wait.h>
#include <errno.h>

                                                    //struct that will act as a message_queue for the communication between tasks
struct msg_queue{
    long messagetype;
    double messagevalue; //child results
};

typedef struct msg_queue msg;



int main(){

clock_t start,end;
key_t kleidi;                                                  //key for the processes to enter the struct
int child_num,i,j;
int messq_id;

fflush(stdin);
printf("Give the number of children you want to create: \n");
scanf("%d",&child_num);

printf("Creating a key for the message queue \n");
kleidi=ftok("/home/haris/Desktop/projectcode/ProjectLS_2a.c",40);   //unique keyid								    //you have to enter different pathfile
printf("The generated key is %d\n",kleidi);                         //needs to have permissions to work								    //local key

start=clock();                         //clock gia tin arxi tis diadikasias
//ftiaxnw to queue
messq_id=msgget(kleidi,IPC_CREAT|0660);
if(messq_id==-1){                                                        //checking if the queue is created
    printf("\a");
    perror("Error at creating the queue");
    exit(1);

}

float arxi=1.0;
float telos=4.0;
unsigned long const n=1e9;
const double dx= (telos-arxi)/n;
double apotelesma=0;
double xi=0;

for (i=0;i<child_num;i++){
    pid_t pid=fork();                    // fork created by child
    if(pid==0)                           //checking if its the child 					//every child has its own range
    {

        for (j=i;j<n;j+=child_num)
        {
            xi=arxi+(j+0.5)*dx;
            apotelesma=apotelesma+(log(xi)*sqrt(xi));
        }

        apotelesma=apotelesma*dx;
        printf("This is child process:  %d with a result of %.4lf \n",getpid(),apotelesma);
        msg msgq;
        msgq.messagetype=1;
        msgq.messagevalue=apotelesma;
        if (msgsnd(messq_id,&msgq,sizeof(double),0)==-1){
            perror("Message was not sent!");
            exit(1);
        }
    exit(0);
    }
    else if(pid==-1){
       perror("Error at fork\n");
       exit(1);
    }
}

double teliko=0;

while(wait(NULL)>0){;}    //waiting children to finish

 printf("Parent %d starts receiving  messages from the queue \n",getppid());

while(child_num>0)
{                           //parent receives the messages

    msg msgq;
    msgrcv(messq_id,&msgq,sizeof(double),1,IPC_NOWAIT);
    teliko=teliko+msgq.messagevalue;
    child_num--;
}

printf("This is the parent process %d and the final result of log(x)*sqrt(x) for the range of [1,4] is %0.4lf\n\n",getppid(),teliko);


msgctl(messq_id,IPC_RMID,NULL);       // IPC_RMID deletes the whole queue immediately if it has the permission to

printf("Program runtime was %lf seconds",(double)(end-start)/CLOCKS_PER_SEC);
return 0;
}
