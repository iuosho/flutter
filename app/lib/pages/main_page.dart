import 'package:flutter/material.dart';

late double screenHeightO;
late double statusBarHeightO;
late double appBarHeightO;
const double containerHeightO = 50.0;

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      theme: ThemeData.light(),

      builder: (BuildContext context, Widget? child) {
        screenHeightO = MediaQuery.of(context).size.height;
        statusBarHeightO = MediaQuery.of(context).padding.top;
        appBarHeightO = AppBar().preferredSize.height;
        return child!;
      },

      home: SampleScreen(),
    );
  }
}


class SampleScreen extends StatefulWidget {
  @override
  _SampleScreenState createState() => _SampleScreenState();
}
class _SampleScreenState extends State<SampleScreen> {

  @override
  Widget build(BuildContext context) {

    debugPrint("全体を描画");

    return Scaffold(

      /// ↓これを追加する ※これがないと、viewInsets.bottom の値を取得できない
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: Text("TestApp"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Text("TextField"),
              alignment: Alignment.center,
              color: Colors.green[200],
              height: containerHeightO,
            ),

            // TextField部分を別クラス化
            TextFieldWidgetO(),
          ],
        ),
      ),
    );
  }
}

/// 別クラス化した TextField を含むウィジェット
class TextFieldWidgetO extends StatefulWidget {
  const TextFieldWidgetO({Key? key}) : super(key: key);

  @override
  State<TextFieldWidgetO> createState() => _TextFieldWidgetOState();
}

class _TextFieldWidgetOState extends State<TextFieldWidgetO> {
  @override
  Widget build(BuildContext context) {

    debugPrint("TextFieldWidgetOを描画");

    // 動的にキーボードの位置（縦幅）を取得
    double textFieldBottomO = MediaQuery.of(context).viewInsets.bottom;
    debugPrint("textFieldBottomO = $textFieldBottomO");

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),

      // TextFieldの高さを計算して算出
      //  画面の縦幅 - ステータスバーの高さ - AppBarの高さ - 上下パディング - 上部Containerの高さ - キーボードの縦幅
      height: screenHeightO - statusBarHeightO - appBarHeightO - 8.0 * 2 - containerHeightO - textFieldBottomO,

      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
    );
  }
}