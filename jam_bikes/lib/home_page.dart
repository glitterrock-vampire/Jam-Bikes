import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> isFavorite = [
    false,
    false
  ]; // Track the favorite state of each bike
  int selectedIndex = 0; // Track the selected index for category tabs

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
            backgroundImage: AssetImage('assets/Avatarme.jpg'),
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
              _buildSearchBar(), // Updated search bar with no icon background and grey text
              SizedBox(height: 20),
              _buildCategoryTabs(), // Updated category tabs with selection and hover effect
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
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10), // Less rounded edges
              border:
                  Border.all(color: Colors.grey[300]!, width: 1), // Less border
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Find motorcycle, etc',
                  hintStyle:
                      TextStyle(color: Colors.grey[500]), // Slightly grey text
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10), // Space between search bar and icon
        Icon(Icons.search,
            color: Color(0xFFC1C1C1)), // No background for the search icon
      ],
    );
  }

  Widget _buildCategoryTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCategoryTab('Favorite', 0),
        _buildCategoryTab('Recommended', 1),
        _buildCategoryTab('Nearby', 2),
        _buildCategoryTab('Best Motorcycle', 3),
      ],
    );
  }

  Widget _buildCategoryTab(String title, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 25, 96, 203)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Roboto',
            fontSize: 14,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildBikeList(BuildContext context) {
    return Center(
      child: Container(
        height:
            260, // Adjusted height to ensure the bikes fit with the description
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBikeCard('assets/yhbike1.png', 0, scale: 1.0),
            SizedBox(width: 16),
            _buildBikeCard('assets/yhbike2.png', 1,
                scale: 0.9), // Adjusted scale
          ],
        ),
      ),
    );
  }

  Widget _buildBikeCard(String imagePath, int index, {double scale = 1.0}) {
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
              Transform.scale(
                scale: scale, // Scale the image
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child:
                      Image.asset(imagePath, height: 140, fit: BoxFit.contain),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Model XYZ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Electric Bike",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: RatingBar.builder(
                  initialRating: 4,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 16.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
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
              child: Icon(
                isFavorite[index] ? Icons.favorite : Icons.favorite_border,
                color: isFavorite[index] ? Colors.red : Colors.black,
                size: 24,
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
