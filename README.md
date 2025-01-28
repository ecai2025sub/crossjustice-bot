# LeXBOT: a Generative - Symbolic Approach to Legislative eXplainability (submitted at ICAIL 2025)

This repository contains the support material for the paper *LeXBOT: a Generative - Symbolic Approach to Legislative eXplainability*.

## Repository Structure  

### `test/`  
This directory contains the code for the quantitative evaluation of Task 1.  
- **`facts_extraction.py`**: The main script for evaluation.  
  - Requires a valid [Together AI](https://www.together.ai/) API key to function properly.  

### `res/`  
This directory stores evaluation results and datasets.
- **Evaluation results**: JSON files containing results at different temperature settings (0.0, 0.3, 0.6, 0.9).  
- **`extraction/`**: Contains the dataset used for testing, including both complex and single extraction scenarios.  

### `src/`  
Contains the main source code.  
- **`prolog/`**: Stores the CrossJustice Prolog sources.  
- **`argumentation/`**: Contains the `arg2p` executable used for conformity evaluation.  
- **`input_facts.py`**: Defines the list of Prolog facts for the CrossJustice system.  
- **`swi_interface.py`**: A Python interface for interacting with the CrossJustice Prolog system.  
- **`app.py`**: The main application containing all the prompts detailed in the paper.

  - To launch the application, run:  
    ```bash
    streamlit run src/app.py
    ```  
  - The script includes pre-configured [Groq](https://groq.com/) API keys. However, their usage is limited, so it is recommended to generate new keys and replace them in the code.  

## Setup and Installation  

1. Clone the repository:  
   ```bash
   git clone https://github.com/icail2025sub/crossjustice-bot.git
   cd crossjustice-bot
   ```  
2. Install system dependencies (tested with Debian Bullseye):  
   ```bash
   xargs sudo apt install -y < packages.txt
   ```  
3. Install Python dependencies (tested with Python 3.12):  
   ```bash
   pip install -r requirements.txt
   ```  
4. Set up API keys (**Optional**):
   - Replace the Groq API key in `src/app.py`.
   - Add a valid Together AI API key for evaluation (`test/facts_extraction.py`).

5. Run the application:  
   ```bash
   streamlit run src/app.py
   ```  
