from app import app
from flask import render_template, Flask, url_for, redirect,request
from app import database as db_helper

@app.route("/")
def index():

    return redirect(url_for('redirected',name=db_helper.get_name()))
    # return render_template("index.html",name=db_helper.get_name())


@app.route("/hello/<string:name>")
def redirected(name):

    # assert name == request.view_args['ccrpc']
    # return render_template("index.html",name=db_helper.get_name())
    return render_template("index.html",name=name)

@app.route("/CCRPC")
def name(name):
    return ''

