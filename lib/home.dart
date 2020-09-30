import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'feedforward.dart';
import 'detail.dart';
import 'result.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<double> inputValue = List(8);

  List<TextEditingController> _teksControl = List(8);
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 8; i++) {
      _teksControl[i] = TextEditingController();
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    for (var i = 0; i < 8; i++) {
      _teksControl[i].dispose();
    }
    super.dispose();
  }

  double _flexHeight(BuildContext context, double height) {
    return (MediaQuery.of(context).size.height * height / 774.8571428571429);
  }

  double _flexWidth(BuildContext context, double width) {
    return (MediaQuery.of(context).size.width * width / 411.42857142857144);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('img/background.jpg'), fit: BoxFit.cover),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: _flexWidth(context, 20),
              vertical: _flexHeight(context, 120),
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 15,
              color: Color.fromRGBO(255, 255, 255, 1),
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: _flexHeight(context, 30),
                  horizontal: _flexWidth(context, 15),
                ),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 15,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                _formRow(
                                  lebar: _flexWidth(context, 135),
                                  panjang: _flexHeight(context, 60),
                                  label: "Pregnancies",
                                  isError: _teksControl[0].text == "",
                                  idDialog: 1,
                                ),
                                _formRow(
                                  lebar: _flexWidth(context, 135),
                                  panjang: _flexHeight(context, 60),
                                  label: "Glucose",
                                  isError: _teksControl[1].text == "",
                                  idDialog: 2,
                                ),
                                _formRow(
                                  lebar: _flexWidth(context, 135),
                                  panjang: _flexHeight(context, 60),
                                  label: "Blood Press",
                                  placeHolder: "mm Hg",
                                  isError: _teksControl[2].text == "",
                                  idDialog: 3,
                                ),
                                _formRow(
                                  lebar: _flexWidth(context, 135),
                                  panjang: _flexHeight(context, 60),
                                  label: "Skin Thck",
                                  placeHolder: "mm",
                                  isError: _teksControl[3].text == "",
                                  idDialog: 4,
                                ),
                                _formRow(
                                  lebar: _flexWidth(context, 135),
                                  panjang: _flexHeight(context, 60),
                                  label: "Insulin",
                                  placeHolder: "mu U/ml",
                                  isError: _teksControl[4].text == "",
                                  idDialog: 5,
                                ),
                                _formRow(
                                  lebar: _flexWidth(context, 135),
                                  panjang: _flexHeight(context, 60),
                                  label: "BMI",
                                  isError: _teksControl[5].text == "",
                                  idDialog: 6,
                                  isBMI: true,
                                ),
                                _formRow(
                                  lebar: _flexWidth(context, 135),
                                  panjang: _flexHeight(context, 60),
                                  label: "DPF",
                                  isError: _teksControl[6].text == "",
                                  idDialog: 7,
                                ),
                                _formRow(
                                  lebar: _flexWidth(context, 135),
                                  panjang: _flexHeight(context, 60),
                                  label: "Age",
                                  placeHolder: "Years",
                                  isError: _teksControl[7].text == "",
                                  idDialog: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Builder(
                            builder: (context) => FloatingActionButton.extended(
                              label: Text(
                                "Diagnosa",
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60)),
                              backgroundColor: Colors.green,
                              onPressed: () {
                                Feed x = Feed();
                                _validation();
                                if (!_isValid) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Data tidak boleh kosong!'),
                                    duration: Duration(milliseconds: 40),
                                  ));
                                  print(inputValue);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Result(
                                        hasil: x.feedForward(inputValue),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _validation() {
    int count = 0;
    for (var i = 0; i < 8; i++) {
      if (_teksControl[i].text != "") {
        inputValue[i] = double.parse(_teksControl[i].text);
      } else if (_teksControl[i].text == "") {
        inputValue[i] = null;
      }
      if (inputValue[i] == null) {
        count++;
      }
    }
    if (count == 0) {
      setState(() {
        _isValid = true;
      });
    } else {
      setState(() {
        _isValid = false;
      });
    }
  }

  Widget _formRow({
    String label,
    double lebar,
    double panjang,
    int idDialog,
    String placeHolder,
    bool isError = false,
    bool isBMI = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.lightBlue,
            width: lebar,
            height: panjang,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          onDoubleTap: () {
            if (idDialog == 6) {
              _hitungBMI();
            }
          },
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          width: lebar,
          child: TextField(
            // enabled: !isBMI,
            controller: _teksControl[(idDialog - 1)],
            onChanged: (value) {
              setState(() {
                isError = false;
              });
            },
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 17),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              labelText: placeHolder,
              labelStyle: TextStyle(color: isError ? Colors.red : Colors.grey),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: IconButton(
            icon: Icon(
              Icons.help_outline,
              color: Colors.blue,
              size: 20,
            ),
            onPressed: () {
              _showDialog(idDialog);
            },
          ),
        ),
      ],
    );
  }

  void _hitungBMI() {
    double w = 0, h = 1;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _validInputBorder = OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.5,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(30),
        );
        // return object of type Dialog
        return AlertDialog(
          title: Text("Hitung BMI"),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: _flexHeight(context, 20),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: _validInputBorder,
                    focusedBorder: _validInputBorder,
                    labelText: "Berat Badan (Kg)",
                  ),
                  onChanged: (value) => w = double.parse(value),
                ),
                SizedBox(
                  height: _flexHeight(context, 20),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: _validInputBorder,
                    focusedBorder: _validInputBorder,
                    labelText: "Tinggi Badan (cm)",
                  ),
                  onChanged: (value) => h = double.parse(value),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text(
                "Hitung",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _teksControl[5].text =
                    (w / pow((h / 100), 2)).toStringAsFixed(2);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog(int idDialog) {
    String title, description, image, about = "";

    switch (idDialog) {
      case 1:
        title = "Pregnancies";
        description = "Number of times pregnant";
        image = "img/pregnancies.jpg";
        about = "Pengambilan fitur number of times pregnant dikarenakan pada saat kehamilan wanita memiliki gula darah yang tinggi. Gula darah pada sebelum kehamilan adalah normal, sedangkan pada saat kehamilan plasenta memproduksi hormon tertentu yang dapat membuat glukosa di darah dan biasanya membuat pankreas membuat cukup banyak insulin untuk mengatasinya. Jika pankreas tidak dapat mengatasi masalah glukosa yang diproduksi oleh hormon pada saat kehamilan akan mengakibatkan perasaan cepat haus, cepat lapar dan ingin terus makan, dan ingin terus buang air kecil. Keadaan ini disebut juga Gestational Diabetes atau diabetes pada kehamilan." +
            "Gestational Diabetes terindikasi oleh wanita hamil 2% sampai 10% setiap tahunnya. Wanita akan lebih terserang Gestational Diabetes jika memiliki berat badan melebihi normal sebelum hamil, memiliki gula darah yang tinggi walaupun belum cukup untuk diagnosa diabetes, memiliki keturunan pengidap diabetes, pernah mengidap diabetes, lebih dari 25 tahun, pernah melahirkan bayi yang beratnya lebih dari 9 Pound, dan hamil pada saat memiliki bayi yang baru saja dilahirkan. Pada saat pengecekan diabetes oleh dokter, dokter akan memberikan sebuah minuman bergula yang akan mengakibatkan naiknya gula darah." +
            "Hasil test tersebut akan dilihat satu jam kemudian dimana melihat bagaimana tubuh akan mengatasi masalah kenaikan gula darah. Jika hasilnya tubuh tidak dapat mengatasi, hasilnya akan menunjukkan tingkat gula darah akan melebihi normal (130 mg/dL). Hasil yang melebihi normala akan membutuhkan beberapa test lagi yang membutuhkan waktu 2 sampai 3 jam atau lebih. Fitur pada Glucose (Plasma Glucose Concentration a 2 hours in an oral glucose tolerance test) diambil karena alasan diatas karena semakin tinggi konsentrasi gula darah pada saat hasil test yang dilakukan maka semakin besar kemungkinan untuk diabetes. " +
            "Gestational Diabetes biasanya terjadi pada kehamilan yang kedua. Dokter akan mengecek apakah  wanita tersebut terkena Gestational Diabetes pada saat antara minggu ke 24  dan 28, bisa saja dicek lebih cepat oleh dokter jika dokter melihat resiko yang tinggi terserang Gestational Diabetes. Diabetes dipengaruhi oleh kehamilan, terlebih lagi jika wanita lebih sering mengalami kehamilan dan sering sekali wanita terkena Gestational Diabetes, sehingga fitur number of times pregnant merupakan alasan pengambilan untuk mengecek diabetes. Semakin banyak wanita tersebut hamil, semakin besar kemungkinannya untuk terkena diabetes.";
        break;
      case 2:
        title = "Glucose";
        description =
            "Plasma glucose concentration a 2 hours in an oral glucose tolerance test";
        image = "img/glucose.png";
        about = "Dokter akan memberikan sebuah minuman bergula yang akan mengakibatkan naiknya gula darah." +
            "Hasil test tersebut akan dilihat satu jam kemudian dimana melihat bagaimana tubuh akan mengatasi masalah kenaikan gula darah. Jika hasilnya tubuh tidak dapat mengatasi, hasilnya akan menunjukkan tingkat gula darah akan melebihi normal (130 mg/dL). Hasil yang melebihi normal akan membutuhkan beberapa test lagi yang membutuhkan waktu 2 sampai 3 jam atau lebih. Fitur pada Glucose (Plasma Glucose Concentration a 2 hours in an oral glucose tolerance test) diambil karena alasan diatas karena semakin tinggi konsentrasi gula darah pada saat hasil test yang dilakukan maka semakin besar kemungkinan untuk diabetes.";
        break;
      case 3:
        title = "Blood Pressure";
        description = "Diastolic blood pressure (mm Hg)";
        image = "img/blood.jpg";
        about = "Pengambilan fitur Blood Pressure atau tekanan darah dikarenakan dikutip dari laman bloodpressureuk.org, dari 25% orang yang mengidap diabetes tipe 1 dan 80% orang yang mengalami diabetes tipe 2 memiliki tekanan darah yang tinggi. Diabates tipe 1 dimana tubuh tidak dapat memproduksi insulin. Diabetes tipe ini umumnya dapat dipelihara atau dijaga maupun diobati dengan suntikan insulin diikuti dengan makan makanan yang sehat dan menjaga aktifitas, sedangkan diabetes tipe 2 dimana keadaan tubuh sudah tidak memproduksi insulin dan bahkan tidak bisa menggunakannya. Diabetes tipe ini umumnya dapat disembuhkan atau diobati dengan makan makanan yang sehat, aktif, dan bahkan suntikan insulin dan obat-obatan juga dibutuhkan." +
            "Jika seseorang memiliki riwayat diabetes ataupun sedang diabetes dapat meningkatkan resiko penyakit hati, stroke, penyakit ginnjal. Begitu juga dengan memiliki riwayat tekanan darah yang tinggi secara bersamaan dengan diabetes dapat menaikkan kemungkinan resiko tersebut.  Menurut Dansinger, Michael tekanan darah yang tinggi dapat menyebabkan banyak komplikasi antara lain diabetes dan penyakit ginjal. Sebagian besar orang yang memiliki tekanan darah tinggi memiliki riwayat diabetes ataupun sebaliknya. Diabetes dapat menyerang pembuluh darah arteri yang dapat memperkeras pembuluh darah yang disebut atherosclerosis. Pengerasan atherosclerosis dapat menyebabkan tingginya tekanan darah, dimana jika tidak diobati akan menimbulkan banyak penyakit lagi antara lain penyakit jantung, penyakit ginjal, dan sebagainya." +
            "Pengambilan fitur ini disebabkan oleh tingginya tingkat hubungan dari tekanan darah dengan penderita diabetes, yaitu dari faktanya dari 25% orang yang mengidap diabetes tipe 1 dan 80% diabetes tipe 2 memiliki tekanan darah yang tinggi dan juga penderita diabetes akan enyerang pembuluh darah aetherosclorosis yang akan menimbulkan tekanan darah tinggi. Orang yang mengidap darah tinggi akan tinggi kemungkinannya mengidap diabetes.";
        break;
      case 4:
        title = "Skin Thickness";
        description = "Triceps skin fold thickness (mm)";
        image = "img/skin.png";
        about = "Pengambilan fitur Skin Thickness atau ketebalan kulit dikarenakan penderita atau pengidap diabetes juga menjadi penyebab masalah pada kulit. Dikutip dari Dansinger, Michael penyakit yang biasa terjadi pada kulit yang terhubung dengan diabetes antara lain gatal-gatal, bisa dikarenakan kecilnya peredaran darah dan penderita biasa merasakannya di bagian bawah kaki. Penyakit kulit yang berhubungan diabetes selanjutnya ialah infeksi bakteri, bakteri yang disebut Staphylococcus. Penyakit ini biasa ditemukan oleh orang yang jarang mengontrol diabetesnya. Penyakit Acanthosis Nigricans adalah penyakit kulit yang biasanya ditemukan pada orang yang menderita diabetes tipe 2, yang menyebabkan hitam dan tebalnya kulit. Penyakit kulit lainnya yang disebabkan oleh diabetes menyebabkan kulit tebal Digital Sclerosis, dan Sclederema Diabeticorum." +
            "Rademaker, Marius dalam jurnalnya membuktikan bahwa penderita diabetes memiliki ketebalan kulit yang sedikit menebal dibanding dengan tidak menderita penyakit diabetes. Hal ini diikuti oleh faktor faktor lain yang menyebabkan menebalnya kulit antara lain umut, jenis kelamin, dan BMI (Body Mass Indeks). Sehingga diabetes juga berhubungan dengan anomali atau kelainan kulit dan menambah tebalnya kulit, semakin tebal kulit seseorang kemungkinan memiliki diabetes juga semakin besar walaupun besar kemungkinannya memiliki angka yang kecil, dikarenakan tingkat ketebalan kulit tidak hanya disebabkan oleh diabetes saja tetapi ada faktor lainnya yang menambah ketebalan kulit.";
        break;
      case 5:
        title = "Insulin";
        description = "2-Hour serum insulin (mu U/ml)";
        image = "img/insulin.jpg";
        break;
      case 6:
        title = "Body Mass Index";
        description = "Body mass index (weight in kg/(height in m)^2)";
        image = "img/bmi.jpg";
        about = "Fitur BMI (Body Mass Index) atau index massa tubuh juga merupakan akibat dari diabetes ataupun sebaliknya. Studi yang dilakukan Gray.N, Relation Between BMI and Diabetes Mellitus and its complication among US older adults yaitu studi tentang hubungan antara BMI dengan penyakit diabetes tipe 2 dengan hasil, hubungan BMI dengan pengidap diabetes memiliki hubungan yang cukup tinggi. Dengan wanita yang memiliki BMI >39 lebih besar 2 kali lipat terkena diabetes dibandingkan BMI kurang dari 39 sampai 25. Tingginya BMI meningkatkan kadar insulin yang berlebihan atau diabetes menimbulkan tingginya insulin sehingga menimbulkan kenaikan berat badan yang berlebihan jika tubuh tidak sanggup melawannya atau memakai insulin.+"
                "Menurut Suszynski, Marie obesitas (berat badan yang berlebihan atau BMI berlebih) dan diabetes tipe 2 memiliki hubungan yang sangat kuat. Semakin besar atau banyak lemak ditubuh semakin besar kemungkinan menimbulkan diabetes. Terlebih lagi jika penderita diabetes memiliki berat badan yang berlebih maka lebih besar lagi resiko komplikasi penyakit jantung dan stroke. Studi menyatakan bahwa lebih dari 14.000 orang dengan berat badan berlebih atau bahkan hanya sedikit berat badan berlebih terindikasi menderita diabetes." +
            "Memiliki berat badan berlebih juga harus dikontrol agar tidak menimbulkan diabetes, terlebih lagi memiliki diabetes dengan berat badan yang berlebih. Perhitungan BMI memiliki pengaruh yang cukup signifikan jika dikaitkan dengan diabetes, semakin besar BMI (berat berlebih) semakin besarnya terkena diabetes.";
        break;
      case 7:
        title = "DPF";
        description = "Diabetes Pedigree Function";
        image = "img/dbf.png";
        about =
            "Diabetes pedigree function Adalah sebuah fungsi algoritma likelihood (naive bayes) diabetes yang berdasarkan sejarah keturunan diabetes dari keluarganya";
        break;
      case 8:
        title = "Age";
        description = "Age (Years)";
        image = "img/age.jpg";
        about =
            "Wanita akan lebih terserang Gestational Diabetes jika memiliki berat badan melebihi normal sebelum hamil, memiliki gula darah yang tinggi walaupun belum cukup untuk diagnosa diabetes, memiliki keturunan pengidap diabetes, pernah mengidap diabetes, lebih dari 25 tahun, pernah melahirkan bayi yang beratnya lebih dari 9 Pound, dan hamil pada saat memiliki bayi yang baru saja dilahirkan";
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: title,
        description: description,
        buttonText: "Detail",
        image: image,
        about: about,
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final String image, about;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.about = "",
    this.image = "",
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding,
              bottom: Consts.padding,
              left: Consts.padding,
              right: Consts.padding,
            ),
            margin: EdgeInsets.only(top: Consts.avatarRadius),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Consts.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail(
                            info: title,
                            about: about,
                          ),
                        ),
                      );
                    },
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: Consts.padding,
            right: Consts.padding,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(160),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
