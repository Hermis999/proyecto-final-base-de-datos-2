/* Configurar la conexión a la base de datos MongoDB*/

/*const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost:27017/miTienda',{
    useNewUrlParser: true,
    useUnifiedTopology: true
}).then(()=> console.log('Conectado a MongoDB'))
.catch((error)=> console.error('Error de conexión a MongoDB',error));*/


/* Configurar la conexión a la base de datos MongoDB Atlas */

const mongoose = require('mongoose');

// Sustituye '<db_password>' por la contraseña de tu base de datos
const dbPassword = 'mongodb';
const dbName = 'miTienda'; // Si la base de datos no existe mongoDB la va a crear
const uri = `mongodb+srv://hermis:${dbPassword}@cluster0.djwrv.mongodb.net/${dbName}?retryWrites=true&w=majority`;


mongoose.connect(uri, {
    useNewUrlParser: true,
    useUnifiedTopology: true
}).then(() => console.log('Conectado a MongoDB Atlas'))
    .catch((error) => console.error('Error de conexión a MongoDB', error));
