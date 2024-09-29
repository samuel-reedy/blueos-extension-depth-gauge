window.onload = function() {
    let idealDepth = 10; // Example value, set this dynamically later
    let currentDepth = 8; // Example value, update via API

    // Function to fetch depth data from BlueOS API or another source
    function fetchDepthData() {
        // Example using fetch API (replace with real API endpoint)
        fetch('http://blueos.local:8080/api/v1/depth')
            .then(response => response.json())
            .then(data => {
                updateCircles(data.idealDepth, data.currentDepth);
            })
            .catch(error => console.error('Error fetching depth data:', error));
    }

    // Function to update the circles based on depth
    function updateCircles(idealDepth, currentDepth) {
        const idealCircle = document.getElementById('ideal-circle');
        const currentCircle = document.getElementById('current-circle');

        // Update content and possibly styles
        idealCircle.innerHTML = `Ideal Depth: ${idealDepth}m`;
        currentCircle.innerHTML = `Current Depth: ${currentDepth}m`;

        // You can also adjust circle size or color based on the difference
        let difference = Math.abs(idealDepth - currentDepth);
        currentCircle.style.borderWidth = `${5 + difference}px`; // Example effect
    }

    // Initial update
    updateCircles(idealDepth, currentDepth);

    // Polling or WebSocket updates (for now, polling every 5 seconds)
    setInterval(fetchDepthData, 5000);
};
