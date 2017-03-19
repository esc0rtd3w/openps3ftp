#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#include "common.h"

int32_t ftpio_open(char* path, int oflags, int32_t* fd);
int32_t ftpio_opendir(char* path, int32_t* fd);
int32_t ftpio_readdir(int32_t fd, ftpdirent* dirent, uint64_t* nread);
int32_t ftpio_read(int32_t fd, char* buf, uint64_t nbytes, uint64_t* nread);
int32_t ftpio_write(int32_t fd, char* buf, uint64_t nbytes, uint64_t* nwrite);
int32_t ftpio_close(int32_t fd);
int32_t ftpio_closedir(int32_t fd);
int32_t ftpio_rename(char* old_path, char* new_path);
int32_t ftpio_chmod(char* path, mode_t mode);
int32_t ftpio_lseek(int32_t fd, int64_t offset, int32_t whence, uint64_t* pos);
int32_t ftpio_mkdir(char* path, mode_t mode);
int32_t ftpio_rmdir(char* path);
int32_t ftpio_unlink(char* path);
int32_t ftpio_stat(char* path, ftpstat* st);
int32_t ftpio_fstat(int32_t fd, ftpstat* st);

#ifdef __cplusplus
}
#endif
