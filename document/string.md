# string.h 中字符串相关函数

## 按功能分类:

---

- **字符串连接**:

>  **strcat**  : char* strcat(char* destination, const char* source);

>  **strncat** : char* strcat(char* destination, const char* source, size_t num);

  `cat` 意思是catenate，连接的意思。

  `strncp` 是`strcat`的安全版本，可以防止越界。

  从定义上可以看出带是将`const`的字符串连接到不带`const`的字符串上。

  ---

- **字符/字符串查找**:

>  **strchr** :
   char* strchr(const char* str, int character);
   char* strchr(char* str, int character);

  查找字符character在str中第一次出现的位置，返回一个指针指向该字符到字符串结尾。

  由于'\0'也是字符串的一部分，故该函数也可以查找结束符。

  `chr`意思应该是`character`。

>  **strrchr** :
   char* strchr(const char* str, int character);
   char* strchr(char* str, int character);

  最后一次出现的位置。 'r'应该是right的意思，也就是从右开始搜索。

>  **strpbrk** :
   const char* strpbrk(const char* str1,const char* str2);
   char* strpbrk(char* str1,const char* str2);

   查找str2中任意字符在str1中第一次出现的位置，返回从整个位置到str1最后的字符串。不包含结束符。

> **strcspn** : size_t strcspn(const char* str1, const char* str2);

  返回的是str1第一次出现str2中任意字符的位置。搜索包含null结束符，所以函数可以返回str1字符串的长度当没有任何匹配的时候。

> **strstr** :
  const char* strstr(const char* str1, const char* str2);
  char* strstr(char* str1, const char* str2);

  匹配完整字符串

  ---

- **字符串比较**:

> **strcmp**: int strcmp(const char* str1, const char* str2);

> **strncmp**: int strcmp(const char* str1, const char* str2, size_t num);

> **strcoll**: int strcoll(const char* str1, const char* str2);

  根据LC_COLIATE比较str1和str2。

  ---

- **字符串拷贝**:

> **strcpy** : char* strcpy(char* destination, const char* source);

> **strncpy** : char* strcpy(char* destination, const char* source, size_t num);

  拷贝source到destination中去。遇到'\0'停止copy。

- **获取字符串长度**:

> **strlen**: size_t strlen(const char* str);

- **拆分字符串**:

> **strtok**: char* strtok(char* str, const char* delimiters);

  `tok`的意思是token，该函数就是将str根据delimiter拆分。
