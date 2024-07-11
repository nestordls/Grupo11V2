import {Router} from 'express';
import pool from '../database.js';

const router = Router();

router.get('/add',(req,res)=>{
    res.render('pacientes/add');
});

router.post('/add',async (req,res)=>{
    try{
        const {NombrePaciente, DocumentoPaciente, idPacientes} =req.body;
        const newPaciente ={
            NombrePaciente, DocumentoPaciente, idPacientes
        }
        await pool.query('INSERT INTO PACIENTES SET ?',[newPaciente]);
        res.redirect('/list');

    }
    catch(err){
        res.status(500).json({message:err.message});

    }
});



router.get('/list', async (req,res)=>{
    try{
        const[result]=await pool.query('SELECT * FROM PACIENTES');
        res.render('pacientes/list', {pacientes:result});
    }
    catch(err){
        res.status(500).json({message:err.message});

    }
});

router.get('/edit/:id', async(req,res)=>{
    try{
        const {id}=req.params;
        const [pacientes] = await pool.query('SELECT * FROM PACIENTES WHERE idPacientes=?',[id]);
        const pacientesEdit= pacientes[0];
        res.render('pacientes/edit',{pacientes:pacientesEdit});     
    }
    catch(err){
        res.status(500).json({message:err.message});
    }
});

router.post('/edit/:id', async(req, res)=>{
    try{
        const {NombrePaciente, DocumentoPaciente,idPacientes} = req.body;
        const {id} = req.params;
        const editPaciente = {NombrePaciente, DocumentoPaciente,idPacientes};
        await pool.query('UPDATE pacientes SET ? WHERE idPacientes=?', [editPaciente, id]);
        res.redirect('/list');
    }
    catch(err){
        res.status(500).json({message:err.message});
    }
});

router.get('/delete/:id', async(req,res)=>{
    try{
        const {id}=req.params;
        await pool.query('DELETE FROM PACIENTES WHERE idPacientes=?',[id]);
        res.redirect('/list');
            }
    catch(err){
        res.status(500).json({message:err.message});
    }  
})


export default router;

