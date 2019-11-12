
# Networking
- Different kinds of communication
    - Pipes: most common inter process communication (IPC)
    - 

## Duplexes
- Half duplex: one-way communication
- Full duplex: two-way duplex

## Pipes
- Usually a half-duplex (can be full, but usually not)
- You can pipe on the command line with `|`, but you can also pipe in the code
    - Use `int pipe(int fd[2])`: the first element is the read end and the second element is the write end
    - Usually a child reads and the parent writes
    - In order to make a pipe survive an exec, make the pipe STDIN/STDOUT
        - Use dup2 to copy the existing pipe end to either STDIN or STDOUT


```c++
#include <unistd.h>

// Other includes
#include <iostream>
using namespace std;
```


```c++
cout << "Creating pipe" << endl;

int p[2];

pipe(p);

cout << "Write fd: " << p[0] << "\nRead fd: " << p[1] << endl;
```

    Creating pipe
    Write fd: 26
    Read fd: 31


- Read and write done with read and write functions
- Uses a buffer so the message might be read in chunks which has to be handled
- `FILE* popen(const char *cmdstring, const char *type)`
    - pipe + fork + dup2 + exec
    - Opens a pipe for the given command
    - Type is either 'w' or 'r' to determine whether the current process is reading or writing
- `int pclose(FILE *fp)`
    - close pipe + waitpid
    - Closes the current pipe and waits for the child to finish


## FIFO
- Example usage: client-server
- Multiple processes write to the FIFO and one process reads
    - How does the server respond? Uses something like sockets)

## Semaphores
- Like a mutex, but can allow a set number of processes to hold the lock at a time


## Shared memory
- Two processes can literally map a section of their memory space to overlap
- Super fast, but very dangerous
- Very few reasonable applications
- If there's that much overlap, it might be best to just multithread a single process

# Sockets
- First you create a socket
    - This returns a file descriptor to that socket
- 3 Steps for connection from server:
    - Bind (`bind()`)
        - Requests port from OS
    - Listen
        - Confirms port with OS which then goes and gets ready to make connections
    - Accept
        - Program blocks and waits to connect to client
        - Returns new file descriptor that represents the given connection
- Connecting from client:
    - Create socket with `bind()`
    - Get address (`struct sockaddr`) to server
        `struct sockaddr_in` has sin_family
    - Call `connect()`
    

# New Functions
- `send()`: sends data to write buffer and returns how much is written
- `recv()`: gets data from buffer
    - Has some useful flag options:
        - MSG_DONTWAIT: don't block for data
        - MSG_PEEK: return a copy of the data, but don't remove it from the buffer (not processing it yet)
        - MSG_WAITALL: wait for the full size we have requested (we know it's coming, we just want to wait until it all gets here)
    


```c++

```
