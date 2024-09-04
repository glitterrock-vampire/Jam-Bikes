import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import "leaflet/dist/leaflet.css";
import { useState, useEffect } from "react";
import L from "leaflet";
import "./index.css"; // Ensure this is imported at the top of index.js

// Custom icon for markers
const customIcon = new L.Icon({
  iconUrl: "/sumn.png", // Path to the image in the public folder
  iconSize: [35, 35], // Customize the icon size
  iconAnchor: [17, 35], // Customize the anchor point
});

// Parish boundaries or centroids for filtering (simplified)
const parishes = [
  { name: "Kingston", coordinates: [17.977, -76.793] },
  { name: "St. Andrew", coordinates: [18.002, -76.799] },
  { name: "St. Thomas", coordinates: [17.946, -76.558] },
  { name: "Portland", coordinates: [18.177, -76.432] },
  { name: "St. Mary", coordinates: [18.268, -76.899] },
  // Add all other parishes...
];

function App() {
  const [earthquakes, setEarthquakes] = useState([]);
  const [year, setYear] = useState("1950"); // Default year filter starts at 1950
  const [parish, setParish] = useState("all"); // Default parish filter
  const [filteredEarthquakes, setFilteredEarthquakes] = useState([]);
  const [bounds, setBounds] = useState(null); // Store map bounds for fitting all markers

  useEffect(() => {
    const currentYear = new Date().getFullYear();
    fetch(
      `https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=1950-01-01&endtime=${currentYear}-12-31&minlatitude=17.5&maxlatitude=19.0&minlongitude=-78.5&maxlongitude=-75.0`
    )
      .then((response) => response.json())
      .then((data) => {
        const parsedEarthquakes = data.features.map((eq) => {
          return {
            id: eq.id,
            place: eq.properties.place,
            magnitude: eq.properties.mag,
            time: new Date(eq.properties.time), // Convert timestamp to Date object
            depth: eq.geometry.coordinates[2], // Depth of the earthquake
            coordinates: [
              eq.geometry.coordinates[1],
              eq.geometry.coordinates[0],
            ], // [lat, lon]
          };
        });
        setEarthquakes(parsedEarthquakes);
      })
      .catch((error) =>
        console.error("Error fetching earthquake data:", error)
      );
  }, []);

  // Update filtered earthquakes whenever the year or parish changes
  useEffect(() => {
    let filtered = earthquakes;

    if (year !== "all") {
      filtered = filtered.filter(
        (eq) => eq.time.getFullYear().toString() === year
      );
    }

    if (parish !== "all") {
      const parishCoordinates = parishes.find(
        (p) => p.name === parish
      ).coordinates;
      filtered = filtered.filter(
        (eq) => L.latLng(eq.coordinates).distanceTo(parishCoordinates) < 50000 // Within 50 km of the parish center
      );
    }

    setFilteredEarthquakes(filtered);

    // Calculate map bounds to fit all markers
    if (filtered.length > 0) {
      const bounds = L.latLngBounds(filtered.map((eq) => eq.coordinates));
      setBounds(bounds);
    }
  }, [year, parish, earthquakes]);

  // Jamaica bounds to restrict map movement outside
  const jamaicaBounds = L.latLngBounds([
    [17.5, -79.0], // Extended Southwest corner further west to -79.0
    [19.0, -75.0], // Northeast corner stays the same
  ]);

  return (
    <div className="container">
      <h1 className="title">Earthquakes in Jamaica</h1>

      {/* Year and Parish filters */}
      <div className="filter-button-container">
        <div className="filter-container">
          <label htmlFor="year-select">Filter by year:</label>
          <select
            id="year-select"
            value={year}
            onChange={(e) => setYear(e.target.value)}
            className="select-dropdown"
          >
            <option value="all">Show All</option>
            {Array.from(
              { length: new Date().getFullYear() - 1950 + 1 },
              (_, i) => (
                <option key={1950 + i} value={1950 + i}>
                  {1950 + i}
                </option>
              )
            )}
          </select>

          <label htmlFor="parish-select">Filter by parish:</label>
          <select
            id="parish-select"
            value={parish}
            onChange={(e) => setParish(e.target.value)}
            className="select-dropdown"
          >
            <option value="all">Show All Parishes</option>
            {parishes.map((p) => (
              <option key={p.name} value={p.name}>
                {p.name}
              </option>
            ))}
          </select>
        </div>
      </div>

      <MapContainer
        center={[18.1096, -77.2975]} // Jamaica coordinates
        zoom={8} // More zoomed-in view
        style={{ height: "600px", width: "100%", borderRadius: "12px" }} // Adjusted width
        className="styled-map"
        bounds={bounds} // Automatically fit the map to show all markers
        boundsOptions={{ padding: [50, 50] }} // Add padding to the bounds
        maxBounds={jamaicaBounds} // Restrict the map to stay within Jamaica with adjusted bounds
        maxBoundsViscosity={1.0} // Prevent panning outside the bounds
      >
        <TileLayer
          url="https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png"
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors & <a href="https://carto.com/">CARTO</a>'
        />

        {/* Render filtered earthquake markers */}
        {filteredEarthquakes.map((eq) => (
          <Marker
            key={eq.id}
            position={eq.coordinates} // Corrected coordinates for Leaflet
            icon={customIcon} // Use the custom icon here
            className="animated-marker"
          >
            <Popup className="popup-content">
              <strong>Location:</strong> {eq.place}
              <br />
              <strong>Magnitude:</strong> {eq.magnitude}
              <br />
              <strong>Time:</strong> {eq.time.toLocaleString()}
              <br />
              <strong>Depth:</strong> {eq.depth} km
            </Popup>
          </Marker>
        ))}
      </MapContainer>
    </div>
  );
}

export default App;
