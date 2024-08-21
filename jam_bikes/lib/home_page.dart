import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> isFavorite = [
    false,
    false
  ]; // Track the favorite state of each bike

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color of the app
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.jpg'),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                'Find your favorite\nmotorcycle !',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Have a very pleasant experience',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              _buildSearchBar(),
              SizedBox(height: 20),
              _buildCategoryTabs(),
              SizedBox(height: 20),
              _buildBikeList(context),
              SizedBox(height: 20),
              _buildAccessoriesSection(), // Re-added the accessories section with modified layout
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
        },
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey[400]!, width: 1.5),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Find motorcycle, etc',
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 12,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.search, color: Color(0xFFC1C1C1)),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: _buildCategoryTab('Favorite', true)),
        Expanded(child: _buildCategoryTab('Recommended', false)),
        Expanded(child: _buildCategoryTab('Nearby', false)),
        Expanded(child: _buildCategoryTab('Best Motorcycle', false)),
      ],
    );
  }

  Widget _buildCategoryTab(String title, bool selected) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Colors.blue[900] : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          fontFamily: 'Roboto',
          fontSize: 14,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildBikeList(BuildContext context) {
    return Center(
      child: Container(
        height: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBikeCard('assets/yhbike1.png', 0),
            SizedBox(width: 16),
            _buildBikeCard('assets/yhbike2.png', 1),
          ],
        ),
      ),
    );
  }

  Widget _buildBikeCard(String imagePath, int index) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(imagePath, height: 140, fit: BoxFit.cover),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFavorite[index] =
                      !isFavorite[index]; // Toggle favorite state
                });
              },
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.6),
                radius: 16, // Make the circle smaller
                child: Icon(
                  isFavorite[index] ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite[index] ? Colors.red : Colors.black,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccessoriesSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(
              0xFFF0F0F0), // Changed background color to match other sections
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset('assets/yhhelmet.png', fit: BoxFit.cover, height: 50),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Helmet',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text('Scooter, bike',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Price',
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                  Text('\$67.87',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16)),
                ],
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
