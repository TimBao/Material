## How to use ant build project?

1. cd yourprojectpath
2. open `cmd`/`shell`
3. use command `android update project -p .` to generate `build.xml`
4. open `project.properties` to set `proguard.config=${sdk.dir}/tools/proguard/proguard-android.txt`
5. use `ant release` or `ant debug` to build project.

## How to sign apk?
1. generate your own keystore file.
2. open `build.xml` to add 

>    <!-- sign for apk -->
>    <property name="has.keystore" value="true" />
>    <property name="has.password" value="true" />
>    <property name="key.store" value="xx.keystore" />
>    <property name="key.alias" value="xx.keystore" />
>    <property name="key.store.password" value="xxxx" />
>    <property name="key.alias.password" value="xxxx" />
