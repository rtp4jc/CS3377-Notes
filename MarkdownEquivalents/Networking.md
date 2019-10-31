
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
