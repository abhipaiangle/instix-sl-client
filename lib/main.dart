import 'package:flutter/material.dart';
import './quote.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Quote> quotes = [
    Quote(author: 'Pulkit  Jindal', text: "The World is good"),
    Quote(author: "Hi", text: "Is this really important"),
  ];

  int hello = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Hello "),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: Image.asset('Assets/Fb.png')),
          ElevatedButton(onPressed: () {}, child: Text("Hi")),
          Text("Hello World"),
          Expanded(
            child: Container(
              child: Text("Hello Bro"),
              padding: EdgeInsets.all(30),
              color: Colors.amber,
            ),
          ),
          Expanded(
            child: Container(
              child: Text("Hello"),
            ),
          ),
          Column(
            children: quotes
                .map((quote) => QuoteCard(
                    quote: quote,
                    delete: () {
                      setState(() {
                        quotes.remove(quote);
                      });
                    }))
                .toList(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            hello = hello + 1;
          });
        },
        child: Icon(Icons.plus_one),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final void Function()? delete;
  QuoteCard({required this.quote, this.delete});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(quote.text, style: TextStyle(color: Colors.amberAccent)),
          SizedBox(height: 10),
          Text(
            quote.author,
            style: TextStyle(color: Colors.red),
          ),
          TextButton.icon(
              onPressed: delete,
              icon: Icon(Icons.delete),
              label: Text("Delete Me")),
          SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }
}
