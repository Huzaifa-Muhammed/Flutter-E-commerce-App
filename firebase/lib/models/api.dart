import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api extends StatefulWidget {
  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  late List dataResponse = [];

  Future<void> apiCall() async {
    final http.Response response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      setState(() {
        dataResponse = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: dataResponse.isEmpty
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: dataResponse.length,
                  itemBuilder: (context, index) {
                    final Map product = dataResponse[index];
                    return ListTile(
                      leading: Image.network(product['image']),
                      title: Text(product['title'] ?? ''),
                      subtitle: Text('\$${product['price']}'),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
