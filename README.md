## Getting Started

### Prerequisites
- Python 3.7+ 
- `pip` package manager

### Installation and Setup

1. **Clone the repository**:
2. **Create and activate a virtual environment**:
   ```bash
   python -m venv venv
   source venv/bin/activate  # For macOS/Linux
   # For Windows, use:
   # venv\Scripts\activate
3. **Install dependencies:**
   ```bash
   pip install Flask
4. **Start the application:**
   ```bash
   python app.py
5.	**Access the application:**
Open your browser and go to http://127.0.0.1:5001/.

### Testing Siege
1.	Ensure Docker is installed and running.
2.	Run the run_siege_tests.sh script:
     ```bash
     ./run_siege_tests.sh
3. Review the logs in the generated siege_output.txt file.

   
   
