import "package:flutter/material.dart";

class SilverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Ejemplo de SliverAppBar'),
              backgroundColor: Colors.blue,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(),
              pinned: true,
              // Añade el texto dentro del SliverAppBar
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'hola mi nombre es abraham max soy estudiante de ingenieria de sistema sy bla bla valgo verga y aja pero todo es una chimba',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
                childCount: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
