# SimpleChat
Simple Chat 

Simple Light chat screen 

This example is demostrate how to make simple chat view lightwaight 

How to use ?
Just you have to create viewcontroller with parentclass <Code>MBChatViewController<code> and call method for set default messages 
<pre>
[self setDefaultMessages:[self defaultMessages]];
</pre>
here is code for how to set default message in chat
<pre>
-(NSArray *)defaultMessages
{
    NSMutableArray *arr =[[NSMutableArray alloc]init];
    
    MBChat *chat =[[MBChat alloc]init];
    chat.message = @"Hi there how are you ?";
    chat.timestamp = @"14342323123";
    chat.isMe = NO;
    chat.isRead = YES;
    
    [arr addObject:chat];
    
    MBChat *chat1 =[[MBChat alloc]init];
    chat1.message = @"i am fine";
    chat1.timestamp = @"14342323123";
    chat1.isMe = YES;
    chat1.isRead = YES;
    
    [arr addObject:chat1];
    
    MBChat *chat2 =[[MBChat alloc]init];
    chat2.message = @"What about you?";
    chat2.timestamp = @"14342323123";
    chat2.isMe = YES;
    chat2.isRead = YES;
    [arr addObject:chat2];
    
    return arr;
}
</pre>

how to append message to chat ?

you can append extra messages by calling <code>[self sendMessage:chat];</code>

<pre>
    MBChat *chat = [[MBChat alloc]init];
    chat.message = msg;
    chat.isMe  = YES;
    [self sendMessage:chat];
</pre>



![Alt text](https://github.com/mitsBhadeshiya/SimpleChat/blob/master/MBChatView/ChatScreeen.png)

