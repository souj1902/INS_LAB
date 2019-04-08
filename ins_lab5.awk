BEGIN{
c=0;
}
{
if($1=="d")
c++;
}
END{
printf("The total no of packets dropped due to congestion is %d\n",c);
} 

