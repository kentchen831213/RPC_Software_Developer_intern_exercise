from app import app
from flask import render_template, Flask, url_for, redirect,request
from app import database as db_helper

@app.route("/")
def index():
    

    return redirect(url_for('redirected',name=db_helper.get_name()))


@app.route("/hello/<string:name>", methods=["POST","GET"])
def redirected(name,number=0):

    
    number = request.form.get('number')
    return render_template("index.html",name=name,number=number)



