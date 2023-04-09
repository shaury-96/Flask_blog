from flask import Flask,render_template,request,session,redirect
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from datetime import datetime
from flask import request
from werkzeug.utils import secure_filename
import json
import os

with open('config.json', 'r') as c:
    params = json.load(c)["params"]

local_server=True
app= Flask(__name__,template_folder='templates')    #object for flask class
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD = params['gmail-password']
)
mail=Mail(app)
app.config['UPLOAD_FOLDER'] = params['upload_location']

if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI']= params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI']= params['local_uri']

db=SQLAlchemy(app)


# with open('config.json','r') as c:
#     params=json.load(c)["params"]


class contacts(db.Model):
    '''
        sno, name phone_num, msg, date, email
    '''
    Sno=db.Column(db.Integer,primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    email = db.Column(db.String(20), nullable=False)

class posts(db.Model):
    Sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(30), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    tagline = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(12), nullable=True)

app.secret_key = 'super-secret-key'
@app.route("/")
# def root():
#     return render_template('index.html', params=params)
@app.route("/index")
def home():
    post = posts.query.filter_by().all()[0:params['no_of_posts']]
    return render_template('index.html',params=params,post=post)

@app.route("/delete/<string:sno>" , methods=['GET', 'POST'])
def delete(sno):
    if "user" in session and session['user']==params['admin_user']:
        post = posts.query.filter_by(Sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect("/dashboard")

@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/dashboard')

@app.route("/uploader",methods=['GET','POST'])
def uploader():
    if "user" in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "Uploaded successfully!"

@app.route("/dashboard", methods=['GET','POST'])
def dashboard():
    if "user" in session and session['user'] == params['admin_user']:
        post = posts.query.all()
        return render_template("dashboard.html", params=params, post=post)

    if request.method == "POST":
        username = request.form.get("uname")
        userpass = request.form.get("pass")
        if username == params['admin_user'] and userpass == params['admin_password']:
            # set the session variable
            session['user'] = username
            post = posts.query.all()
            return render_template("dashboard.html", params=params, post=post)
    else:
        return render_template("login.html", params=params)

@app.route("/edit/<string:sno>" , methods=['GET', 'POST'])
def edit(sno):
    if "user" in session and session['user']==params['admin_user']:
        if request.method=="POST":
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if sno=='0':
                post = posts(title=box_title, slug=slug, content=content, tagline=tline, date=date,img_file=img_file)
                db.session.add(post)
                db.session.commit()
                # return redirect('/edit/0')

            else:
                post = posts.query.filter_by(Sno=sno).first()
                post.title = box_title
                post.tagline = tline
                post.slug = slug
                post.content = content
                post.img_file = img_file
                post.date = date
                db.session.commit()
                return redirect('/edit/'+sno)

        post = posts.query.filter_by(Sno=sno).first()
        return render_template('edit.html', params=params,post=post,sno=sno)


@app.route("/about")
def about():
    return render_template('about.html',params=params)

@app.route("/post/<string:post_slug>",methods=['GET'])
def post_route(post_slug):
    po=posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html',params=params,post=po)
@app.route("/contact", methods=['GET','POST'])
def contact():
    if(request.method=='POST'):
        '''Fetch data and add it to the database'''
        '''Fetch data->add entry to database through names of elements whose data has to be fetched'''
        name=request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')

        entry=contacts(name=name,phone_num = phone, msg = message, date= datetime.now(),email = email)
        db.session.add(entry)
        db.session.commit()

        mail.send_message('New message from'+name, sender=email, recipents=params['gmail-user'], body=message+"\n"+phone)

    return render_template('contact.html', params=params)


app.run(debug=True)
