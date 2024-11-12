import sys
import os
from flask import Flask, jsonify, request
sys.path.append(os.path.join(os.path.dirname(__file__), 'chemicalfun'))
import chemicalfun as cf

app = Flask(__name__)
@app.route('/generate_reactions', methods=['POST'])
def generate_reactions():
    formulas = request.json.get('formulas', [])
    if not formulas:
        return jsonify({"error": "no formulas specified"}), 400
    try:
        chemicalreactions = cf.ChemicalReactions(formulas)
        reactions = chemicalreactions.generateReactions()
        reactions_dict = [{el[0]: el[1] for el in r} for r in reactions]
        return jsonify(reactions_dict)
    except Exception as e:
        return jsonify({"error": str(e)}), 500
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
