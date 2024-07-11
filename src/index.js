import express from 'express';
import morgan from 'morgan';
import {engine} from 'express-handlebars';
import {join,dirname} from 'path';
import { fileURLToPath } from 'url';
import pacientesRoutes from './routes/pacientes.routes.js';


//Initializacion
const app = express();
const _dirname = dirname (fileURLToPath(import.meta.url));

//Configuraciones
app.set('port',process.env.PORT || 3000);
app.set('views', join (_dirname,'views'));
app.engine('.hbs', engine({
    defaultLayout:'main',
    layoutsDir: join(app.get('views'),'layouts'),
    partialsDir: join(app.get('views'),'partials'),
    extname: '.hbs'
}));

app.set('view engine','.hbs');

//Middlewares
app.use(morgan('dev'));
app.use(express.urlencoded({extended: false}));
app.use(express.json());

//Rutas
app.get('/', (req,res)=>{
    res.render('index')
})

app.use(pacientesRoutes);


//Public
app.use(express.static(join(_dirname, 'public')));

//Run Server
app.listen(app.get('port'),()=>
    console.log('Server activo en puerto',app.get('port')));

