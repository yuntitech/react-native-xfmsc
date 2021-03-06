# react-native-xfmsc
科大讯飞语音云客户端 React Native 组件。
可配置英文或中文测评。
此项目参考了 https://github.com/pj0579/react-native-xfei 代码。

![ScreenCapture](https://github.com/jhzzzz/react-native-xfmsc/blob/master/example/screenshot.png)


## 使用说明
### Android
1. android/setting.pradle 添加：
```
include ':react-native-xfmsc'
project(':react-native-xfmsc').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-xfmsc/android')
```

2. android/app/build.gradle 添加依赖：
```
dependencies {   compile project(':react-native-xfmsc')
```

3. mainActivity onCreate 时初始化msc客户端：
```
SpeechUtility.createUtility(this, SpeechConstant.APPID + "=改成你的AppId");`
```

4. MainApplication 中添加以下内容：
```
import com.hosoft.xfei.XfeiPackage;
```
```
getPackages 中加入 new XfeiPackage()
```
```
SpeechUtility.createUtility(this, SpeechConstant.APPID + "=改成你的AppId");`
```

5. 在语音云申请应用，并将下载的Android SDK中的msc.jar拷贝到libs目录中，相关平台.so文件拷贝到jniLibs目录中。

### IOS

1. AppDelegate.m
```
#import "Xfei.h"
...
(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions<br/>
{
    …
    //Init iflytek
    [RCTXfei crateMyUtility:@"改成你的AppId"];
    …
}
```

2. 在语音云申请应用，并将下载的iOS SDK中 iflyMSC.Framework 拷贝到 react-native-xfmsc ios 目录中覆盖原文件。

### javascript

参考示例：
```
import XfeiModule from 'react-native-xfmsc';
...
    onClickStart() {
        console.log('onClickStart');

        XfeiModule.startRecord("你好，吃过了吗", 'read_syllable')
    };

    onClickStop() {
        console.log('onClickStop');
        XfeiModule.stopRecord();
    };

    onISECallback =(body) => {
        var json = JSON.stringify(body);
        console.log(json);

        let state = this.state;

        state.evalResult.push(json);
        this.setState({
            evalResult:state.evalResult
        })

    };

    componentWillMount() {
        const moduleEvent = new NativeEventEmitter(XfeiModule);
        this.listener = moduleEvent.addListener('onISECallback', this.onISECallback);  //对应了原生端的名字
    };

    componentWillUnmount() {
        this.listener && this.listener.remove();  //记得remove哦
        this.listener = null;
    };
...    
```

### 接口列表

1. 设置参数：
    **setParameter**(String key, String value)

    _key_：参数名，具体参数列表请参考讯飞语音云SDK。

    *value*：参数值，具体请参考讯飞语音云SDK。

2. 开始录音评测：
    **startRecord**(String evalPaper, String category)

    _evalPaper_ - 评测内容试卷，试卷格式请参考讯飞语音云SDK。

    _category_ - 评测题型，可以是字、词、篇章，具体请参考讯飞语音云SDK。

3. 停止录音：
    **stopRecord**()

4. 取消：
    **cancel**()

5. 事件回调：
    **onISECallback**(body)

    回调内容为json对象，包含以下字段：
    - _type_，包括：
    - _file_: 录音文件，评测完毕后可以回放
      - _result_: 评测结果 XML 格式
      - _volumn_: 录音音量，应用程序可据此进行音量显示
      - _error_: 错误消息

    - _msg_： 回调消息
    - _data_： 回调具体内容 
