#include <jni.h>

#include "TestCpp.h"

#ifndef _CDVCppBridge

#ifdef __cplusplus
extern "C" {
#endif

JNIEXPORT jlong JNICALL
Java_com_tkyaji_cordova_CDVCppBridge_TestCpp0new(JNIEnv *env, jobject instance) {


    TestCpp* ret = new TestCpp();

    return (jlong)ret;
}

JNIEXPORT void JNICALL
Java_com_tkyaji_cordova_CDVCppBridge_TestCpp0delete(JNIEnv *env, jobject instance, jlong cppInstancePtr) {
    TestCpp *cppInstance = (TestCpp*)cppInstancePtr;

    delete cppInstance;


}

JNIEXPORT jint JNICALL
Java_com_tkyaji_cordova_CDVCppBridge_TestCpp0mm0testMethod(JNIEnv *env, jobject instance, jlong cppInstancePtr, jint param0, jstring param1, jdouble param2, jboolean param3) {
    TestCpp *cppInstance = (TestCpp*)cppInstancePtr;
    const char *native_param1 = env->GetStringUTFChars(param1, 0);
    int ret = cppInstance->testMethod((int)param0, native_param1, (double)param2, (bool)param3);
    env->ReleaseStringUTFChars(param1, native_param1);
    return (jint)ret;
}

JNIEXPORT jstring JNICALL
Java_com_tkyaji_cordova_CDVCppBridge_TestCpp0sm0staticTestMethod(JNIEnv *env, jobject instance) {


    const char* ret = TestCpp::staticTestMethod();

    return env->NewStringUTF(ret);;
}


#ifdef __cplusplus
}
#endif

#endif
