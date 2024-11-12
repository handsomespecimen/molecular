import sys
import os
from flask import Flask, jsonify, request
sys.path.append(os.path.join(os.path.dirname(__file__), 'chemicalfun'))
import chemicalfun as cf
app = Flask(__name__)

@app.route('/generate_reactions', methods=['POST'])
def generate_reactions():
    try:
        formulas = request.json.get('formulas')
        if not formulas:
            return jsonify({'error': 'No formulas provided'}), 400
        chemicalReactions = cf.ChemicalReactions(formulas)
        reactions = chemicalReactions.generateReactions()
        reactions_list = [{'substance': el[0], 'coefficient': el[1]} for r in reactions for el in r]
        return jsonify({'reactions': reactions_list})
    except Exception as e:
        print(f"Error: {str(e)}")
        return jsonify({'error': 'An error occurred while processing your request'}), 500
if __name__ == '__main__':
    app.run(debug=True)
