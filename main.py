from flask import Flask, jsonify, request
import chemicalfun as cf

app = Flask(__name__)

@app.route('/generate_reactions', methods=['POST'])
def generate_reactions():
    formulas = request.json.get('formulas', [])
    chemicalReactions = cf.ChemicalReactions(formulas)
    reactions = chemicalReactions.generateReactions()
    
    reactions_dict = [{el[0]: el[1] for el in r} for r in reactions]
    return jsonify(reactions_dict)

if __name__ == '__main__':
    app.run(debug=True)
