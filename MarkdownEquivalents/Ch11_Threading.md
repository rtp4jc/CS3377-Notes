```c++
#include <pthread.h>
```

# Threading
*A lot of this was missed trying to set up this note environment*
## Working with threads:
- `pthread_t`:
    - Object that contains thread information
    - Not just a number like pid_t
- `pthread_t pthread_self(void)`:
    - Get your own info
    - Should never fail
- `int pthread_equal(pthread_t thread1, pthread_t thread2)`:
    - Returns 0 for false, non-0 for true
- Creating a thread:
    - Threads can take an arbitrary input and give an arbitrary output
    - We use `void*` to do so
- `int pthread_create(pthread_t *tidp, const pthread_attr_t *attr, void *(start_rtn)(void *), void *arg)`:
    - `tidp`: structure to fill in
    - `attr`: thread attributes (can be NULL)
    - `start_rtn`: function to start with (returns void*)
    - `arg`: arguments to be provided to the function
- `void pthread_exit(void *returnValue)`: stops thread
- `int pthread_cancel(pthread_t tid)`: requests for thread to stop
    - Doesn't force it to stop
    - Non-blocking so it won't wait for it to finish
- `int pthread_join(pthread_t tid, void **returnValuePointer)`: waits for thread to finish
- `pthread_detatch`: detaches thread so it can't be waited on anymore
    - Useful when you don't care about the thread once created (memory is cleaned up for you when it finishes)
   
- **When compiling a multithreaded program use gcc -pthread**

### pthread_attr_t
- Used for sending attribute data
- `int pthread_attr_init(pthread_attr_t*attr)`: initializes the structure
    - Must be used before using attribute
- `int pthread_attr_destroy(pthread_attr_t*attr)`
- Detached state:
    - PTHREAD_CREATE_DETATCHED: creates it detatched
    - PTHREAD_CREATE_JOINABLE
    - `int pthread_attr_getdetatchstate(const pthread_attr_t*attr,int *detatchstate)`
    - `int pthread_attr_setdetatchstate(pthread_attr_t*attr, int detatchstate)`

## Working with Mutexes:
- `pthread_mutex_init(pthread_mutex_t*mutex, const pthread_mutexattr_t*attr)`: initializes the pthread mutext
    - Again attr can be NULL
- `int pthread_mutex_destroy(pthread_mutex_t*mutex)`: not usually useful, just makes the mutex unusable
- `int pthread_mutex_lock(pthread_mutex_t*mutex)`: acquires lock
- `int pthread_mutex_unlock(pthread_mutex_t*mutex)`: releases lock
- `int pthread_mutex_trylock(pthread_mutex_t*mutex)`: non-blocking lock aquisition
    - If not available returns EBUSY
    
### pthread_mutexattr_t
- Same as thread_attr_t, have to use a function
- `int pthread_mutexattr_init(pthread_mutexattr_t*attr)`
- `int    pthread_mutexattr_destroy(pthread_mutexattr_t*attr)`
- Different mutex types:
    - PTHREAD_MUTEX_NORMAL
        - The default
        - Re-locking will deadlock
    - PTHREAD_MUTEX_ERRORCHECK
        - If you relock, it will error out
        - Error if you unlock without locking
    - PTHREAD_MUTEX_RECURSIVE
        - Kinda makes it a semaphore
        - Counts the number of locks and unlocks
        - Not safe for conditions
    - PTHREAD_MUTEX_DEFAULT
- `int pthread_mutexattr_gettype(pthread_mutexattr_t*attr,int *type)`
- `int pthread_mutexattr_settype(pthread_mutexattr_t*attr,int type)`

## Read-Write Locks
- Shortened to "rwlock"
- Similar methods to mutexes
- `int pthread_rwlock_init(pthread_rwlock_t*rwlock, const pthread_rwlockattr_t*attr)`
    - Attr can be NULL
- `int pthread_rwlock_destroy(pthread_rwlock_t*rwlock)`
- `int pthread_rwlock_rdlock(pthread_rwlock_t*rwlock)`
- `int pthread_rwlock_wrlock(pthread_rwlock_t*rwlock)`
- `int pthread_rwlock_unlock(pthread_rwlock_t*rwlock)`

## Conditions
- Used to indicate when something is ready (communicates across threads)
- `int pthread_cond_init(pthread_cond_t*cond, const pthread_condattr_t*attr)`: create condition
- `int pthread_cond_destroy(pthread_cond_t*cond)`
- `int pthread_cond_wait(pthread_cond_t*cond,pthread_mutex_t*mutex)`: waits for condition to signal
    - Mutex must be locked before calling
    - Will unlock the mutex to wait, but will re-lock before returning
- `int pthread_cond_signal(pthread_cond_t*cond)`   

## Thread-safe functions
- Means the functions can be called in different threads without stepping on itself
- Sometimes indicated as MT-safe in man page
- Many builtins aren't thread safe
    - `setenv` (might mess with `getenv`)
        - Solved with a rw lock
        
## Thread-Specific Memory
- Uses keys to avoid *accidental* memory tangling
- `int pthread_key_create(pthread_key_t*keyp ,void (*destructor)(void *))`
    - Creates key for all threads
    - Destructor is optional for cleaning up the data after the key use is finished
- `int pthread_key_delete(pthread_key_tkey)`
    - Doesn't call destructor for some reason
- `void *pthread_getspecific(pthread_key_tkey)`
    - Gets a key?
- `int    pthread_setspecific(pthread_key_tkey,const void *value)`


## Thread Cancellation
- Option 1:
    - Threads have to check if they've been asked to cancel
- Option 2:
    - Threads ignore all requests
- Option 3:
    - Threads can be cancelled immediately
    - **Doesn't free memory or unlock mutexes, don't use**
- `int pthread_setcancelstate(int state, int *oldstate)`
- `oid pthread_testcancel(void)`: If there are any cancel requests, it dies right there
- `int pthread_setcanceltype(int type,int *oldtype)`


## Other Threading Notes
- Signals might go to a random thread so basically try to avoid signal handlers
- When forking, only the thread that called it runs in the child process, the others are suspended.
    - Solution: run exec fast, don't call functions like malloc
- File descriptors are also shared
    - Make sure to use pread and pwrite to avoid conflicts



```c++

```
