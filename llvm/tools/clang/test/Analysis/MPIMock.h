// Message Passing Interface mock header. Mocks MPI constants and functions, in
// order to make them available in distinct integration test files.

#define NULL 0

// mock types
typedef int MPI_Datatype;
typedef int MPI_Comm;
typedef int MPI_Request;
typedef int MPI_Status;
typedef int MPI_Op;
typedef int int8_t;
typedef int uint8_t;
typedef int uint16_t;
typedef int int64_t;
namespace std { template<class T> struct complex { T real; T imag; }; }

// mock constants
#define MPI_DATATYPE_NULL 0
#define MPI_CHAR 0
#define MPI_BYTE 0
#define MPI_INT 0
#define MPI_LONG 0
#define MPI_LONG_DOUBLE 0
#define MPI_UNSIGNED 0
#define MPI_INT8_T 0
#define MPI_UINT8_T 0
#define MPI_UINT16_T 0
#define MPI_C_LONG_DOUBLE_COMPLEX 0
#define MPI_FLOAT 0
#define MPI_DOUBLE 0
#define MPI_CXX_BOOL 0
#define MPI_CXX_FLOAT_COMPLEX 0
#define MPI_CXX_DOUBLE_COMPLEX 0
#define MPI_CXX_LONG_DOUBLE_COMPLEX 0
#define MPI_IN_PLACE 0
#define MPI_COMM_WORLD 0
#define MPI_STATUS_IGNORE 0
#define MPI_STATUSES_IGNORE 0
#define MPI_SUM 0

// mock functions
int MPI_Comm_size(MPI_Comm, int *);
int MPI_Comm_rank(MPI_Comm, int *);
int MPI_Send(const void *, int, MPI_Datatype, int, int, MPI_Comm);
int MPI_Recv(void *, int, MPI_Datatype, int, int, MPI_Comm, MPI_Status *);
int MPI_Isend(const void *, int, MPI_Datatype, int, int, MPI_Comm,
    MPI_Request *);
int MPI_Irecv(void *, int, MPI_Datatype, int, int, MPI_Comm, MPI_Request *);
int MPI_Wait(MPI_Request *, MPI_Status *);
int MPI_Waitall(int, MPI_Request[], MPI_Status[]);
int MPI_Reduce(const void *, void *, int, MPI_Datatype, MPI_Op, int, MPI_Comm);
int MPI_Ireduce(const void *, void *, int, MPI_Datatype, MPI_Op, int, MPI_Comm,
    MPI_Request *);
int MPI_Bcast(void *, int count, MPI_Datatype, int, MPI_Comm);
