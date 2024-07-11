import {createPool} from 'mysql2/promise';

const pool = createPool({
    host:'localhost',
    port:'3306',
    user: 'root',
    password:'Ciro@2024',
    database: 'turnosgs_grupo11' 
});

export default pool;