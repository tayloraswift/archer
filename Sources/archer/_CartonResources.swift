enum _CartonResources
{
    static func js(wasm:String) -> String { """
var V=class f{static read_bytes(t,e){let i=new f;return i.buf=t.getUint32(e,!0),i.buf_len=t.getUint32(e+4,!0),i}static read_bytes_array(t,e,i){let c=[];for(let r=0;r<i;r++)c.push(f.read_bytes(t,e+8*r));return c}},W=class f{static read_bytes(t,e){let i=new f;return i.buf=t.getUint32(e,!0),i.buf_len=t.getUint32(e+4,!0),i}static read_bytes_array(t,e,i){let c=[];for(let r=0;r<i;r++)c.push(f.read_bytes(t,e+8*r));return c}},st=0,it=1,X=2;var ot=2,y=3,P=4;var F=class{head_length(){return 24}name_length(){return this.dir_name.byteLength}write_head_bytes(t,e){t.setBigUint64(e,this.d_next,!0),t.setBigUint64(e+8,this.d_ino,!0),t.setUint32(e+16,this.dir_name.length,!0),t.setUint8(e+20,this.d_type)}write_name_bytes(t,e,i){t.set(this.dir_name.slice(0,Math.min(this.dir_name.byteLength,i)),e)}constructor(t,e,i){this.d_ino=0n;let c=new TextEncoder().encode(e);this.d_next=t,this.d_namlen=c.byteLength,this.d_type=i,this.dir_name=c}};var at=1;var b=class{write_bytes(t,e){t.setUint8(e,this.fs_filetype),t.setUint16(e+2,this.fs_flags,!0),t.setBigUint64(e+8,this.fs_rights_base,!0),t.setBigUint64(e+16,this.fs_rights_inherited,!0)}constructor(t,e){this.fs_rights_base=0n,this.fs_rights_inherited=0n,this.fs_filetype=t,this.fs_flags=e}};var J=1,B=2,ft=4,Q=8,L=class{write_bytes(t,e){t.setBigUint64(e,this.dev,!0),t.setBigUint64(e+8,this.ino,!0),t.setUint8(e+16,this.filetype),t.setBigUint64(e+24,this.nlink,!0),t.setBigUint64(e+32,this.size,!0),t.setBigUint64(e+38,this.atim,!0),t.setBigUint64(e+46,this.mtim,!0),t.setBigUint64(e+52,this.ctim,!0)}constructor(t,e){this.dev=0n,this.ino=0n,this.nlink=0n,this.atim=0n,this.mtim=0n,this.ctim=0n,this.filetype=t,this.size=e}};var St=0,rt=class{write_bytes(t,e){t.setUint32(e,this.pr_name.byteLength,!0)}constructor(t){this.pr_name=new TextEncoder().encode(t)}},$=class f{static dir(t){let e=new f;return e.tag=St,e.inner=new rt(t),e}write_bytes(t,e){t.setUint32(e,this.tag,!0),this.inner.write_bytes(t,e+4)}};var yt=class{enable(t){this.log=Tt(t===void 0?!0:t,this.prefix)}get enabled(){return this.isEnabled}constructor(t){this.isEnabled=t,this.prefix="wasi:",this.enable(t)}};function Tt(f,t){return f?console.log.bind(console,"%c%s","color: #265BA0",t):()=>{}}var S=new yt(!1);var G=class extends Error{constructor(t){super("exit with exit code "+t),this.code=t}},_t=class{start(t){this.inst=t;try{return t.exports._start(),0}catch(e){if(e instanceof G)return e.code;throw e}}initialize(t){this.inst=t,t.exports._initialize&&t.exports._initialize()}constructor(t,e,i,c={}){this.args=[],this.env=[],this.fds=[],S.enable(c.debug),this.args=t,this.env=e,this.fds=i;let r=this;this.wasiImport={args_sizes_get(n,s){let o=new DataView(r.inst.exports.memory.buffer);o.setUint32(n,r.args.length,!0);let a=0;for(let _ of r.args)a+=_.length+1;return o.setUint32(s,a,!0),S.log(o.getUint32(n,!0),o.getUint32(s,!0)),0},args_get(n,s){let o=new DataView(r.inst.exports.memory.buffer),a=new Uint8Array(r.inst.exports.memory.buffer),_=s;for(let l=0;l<r.args.length;l++){o.setUint32(n,s,!0),n+=4;let p=new TextEncoder().encode(r.args[l]);a.set(p,s),o.setUint8(s+p.length,0),s+=p.length+1}return S.enabled&&S.log(new TextDecoder("utf-8").decode(a.slice(_,s))),0},environ_sizes_get(n,s){let o=new DataView(r.inst.exports.memory.buffer);o.setUint32(n,r.env.length,!0);let a=0;for(let _ of r.env)a+=_.length+1;return o.setUint32(s,a,!0),S.log(o.getUint32(n,!0),o.getUint32(s,!0)),0},environ_get(n,s){let o=new DataView(r.inst.exports.memory.buffer),a=new Uint8Array(r.inst.exports.memory.buffer),_=s;for(let l=0;l<r.env.length;l++){o.setUint32(n,s,!0),n+=4;let p=new TextEncoder().encode(r.env[l]);a.set(p,s),o.setUint8(s+p.length,0),s+=p.length+1}return S.enabled&&S.log(new TextDecoder("utf-8").decode(a.slice(_,s))),0},clock_res_get(n,s){let o;switch(n){case 1:{o=5000n;break}case 0:{o=1000000n;break}default:return 52}return new DataView(r.inst.exports.memory.buffer).setBigUint64(s,o,!0),0},clock_time_get(n,s,o){let a=new DataView(r.inst.exports.memory.buffer);if(n===0)a.setBigUint64(o,BigInt(new Date().getTime())*1000000n,!0);else if(n==1){let _;try{_=BigInt(Math.round(performance.now()*1e6))}catch{_=0n}a.setBigUint64(o,_,!0)}else a.setBigUint64(o,0n,!0);return 0},fd_advise(n,s,o,a){return r.fds[n]!=null?0:8},fd_allocate(n,s,o){return r.fds[n]!=null?r.fds[n].fd_allocate(s,o):8},fd_close(n){if(r.fds[n]!=null){let s=r.fds[n].fd_close();return r.fds[n]=void 0,s}else return 8},fd_datasync(n){return r.fds[n]!=null?r.fds[n].fd_sync():8},fd_fdstat_get(n,s){if(r.fds[n]!=null){let{ret:o,fdstat:a}=r.fds[n].fd_fdstat_get();return a?.write_bytes(new DataView(r.inst.exports.memory.buffer),s),o}else return 8},fd_fdstat_set_flags(n,s){return r.fds[n]!=null?r.fds[n].fd_fdstat_set_flags(s):8},fd_fdstat_set_rights(n,s,o){return r.fds[n]!=null?r.fds[n].fd_fdstat_set_rights(s,o):8},fd_filestat_get(n,s){if(r.fds[n]!=null){let{ret:o,filestat:a}=r.fds[n].fd_filestat_get();return a?.write_bytes(new DataView(r.inst.exports.memory.buffer),s),o}else return 8},fd_filestat_set_size(n,s){return r.fds[n]!=null?r.fds[n].fd_filestat_set_size(s):8},fd_filestat_set_times(n,s,o,a){return r.fds[n]!=null?r.fds[n].fd_filestat_set_times(s,o,a):8},fd_pread(n,s,o,a,_){let l=new DataView(r.inst.exports.memory.buffer),p=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let E=V.read_bytes_array(l,s,o),w=0;for(let u of E){let{ret:R,data:N}=r.fds[n].fd_pread(u.buf_len,a);if(R!=0)return l.setUint32(_,w,!0),R;if(p.set(N,u.buf),w+=N.length,a+=BigInt(N.length),N.length!=u.buf_len)break}return l.setUint32(_,w,!0),0}else return 8},fd_prestat_get(n,s){let o=new DataView(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let{ret:a,prestat:_}=r.fds[n].fd_prestat_get();return _?.write_bytes(o,s),a}else return 8},fd_prestat_dir_name(n,s,o){if(r.fds[n]!=null){let{ret:a,prestat:_}=r.fds[n].fd_prestat_get();if(_==null)return a;let l=_.inner.pr_name;return new Uint8Array(r.inst.exports.memory.buffer).set(l.slice(0,o),s),l.byteLength>o?37:0}else return 8},fd_pwrite(n,s,o,a,_){let l=new DataView(r.inst.exports.memory.buffer),p=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let E=W.read_bytes_array(l,s,o),w=0;for(let u of E){let R=p.slice(u.buf,u.buf+u.buf_len),{ret:N,nwritten:x}=r.fds[n].fd_pwrite(R,a);if(N!=0)return l.setUint32(_,w,!0),N;if(w+=x,a+=BigInt(x),x!=R.byteLength)break}return l.setUint32(_,w,!0),0}else return 8},fd_read(n,s,o,a){let _=new DataView(r.inst.exports.memory.buffer),l=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let p=V.read_bytes_array(_,s,o),E=0;for(let w of p){let{ret:u,data:R}=r.fds[n].fd_read(w.buf_len);if(u!=0)return _.setUint32(a,E,!0),u;if(l.set(R,w.buf),E+=R.length,R.length!=w.buf_len)break}return _.setUint32(a,E,!0),0}else return 8},fd_readdir(n,s,o,a,_){let l=new DataView(r.inst.exports.memory.buffer),p=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let E=0;for(;;){let{ret:w,dirent:u}=r.fds[n].fd_readdir_single(a);if(w!=0)return l.setUint32(_,E,!0),w;if(u==null)break;if(o-E<u.head_length()){E=o;break}let R=new ArrayBuffer(u.head_length());if(u.write_head_bytes(new DataView(R),0),p.set(new Uint8Array(R).slice(0,Math.min(R.byteLength,o-E)),s),s+=u.head_length(),E+=u.head_length(),o-E<u.name_length()){E=o;break}u.write_name_bytes(p,s,o-E),s+=u.name_length(),E+=u.name_length(),a=u.d_next}return l.setUint32(_,E,!0),0}else return 8},fd_renumber(n,s){if(r.fds[n]!=null&&r.fds[s]!=null){let o=r.fds[s].fd_close();return o!=0?o:(r.fds[s]=r.fds[n],r.fds[n]=void 0,0)}else return 8},fd_seek(n,s,o,a){let _=new DataView(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let{ret:l,offset:p}=r.fds[n].fd_seek(s,o);return _.setBigInt64(a,p,!0),l}else return 8},fd_sync(n){return r.fds[n]!=null?r.fds[n].fd_sync():8},fd_tell(n,s){let o=new DataView(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let{ret:a,offset:_}=r.fds[n].fd_tell();return o.setBigUint64(s,_,!0),a}else return 8},fd_write(n,s,o,a){let _=new DataView(r.inst.exports.memory.buffer),l=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let p=W.read_bytes_array(_,s,o),E=0;for(let w of p){let u=l.slice(w.buf,w.buf+w.buf_len),{ret:R,nwritten:N}=r.fds[n].fd_write(u);if(R!=0)return _.setUint32(a,E,!0),R;if(E+=N,N!=u.byteLength)break}return _.setUint32(a,E,!0),0}else return 8},path_create_directory(n,s,o){let a=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let _=new TextDecoder("utf-8").decode(a.slice(s,s+o));return r.fds[n].path_create_directory(_)}else return 8},path_filestat_get(n,s,o,a,_){let l=new DataView(r.inst.exports.memory.buffer),p=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let E=new TextDecoder("utf-8").decode(p.slice(o,o+a)),{ret:w,filestat:u}=r.fds[n].path_filestat_get(s,E);return u?.write_bytes(l,_),w}else return 8},path_filestat_set_times(n,s,o,a,_,l,p){let E=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let w=new TextDecoder("utf-8").decode(E.slice(o,o+a));return r.fds[n].path_filestat_set_times(s,w,_,l,p)}else return 8},path_link(n,s,o,a,_,l,p){let E=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[n]!=null&&r.fds[_]!=null){let w=new TextDecoder("utf-8").decode(E.slice(o,o+a)),u=new TextDecoder("utf-8").decode(E.slice(l,l+p)),{ret:R,inode_obj:N}=r.fds[n].path_lookup(w,s);return N==null?R:r.fds[_].path_link(u,N,!1)}else return 8},path_open(n,s,o,a,_,l,p,E,w){let u=new DataView(r.inst.exports.memory.buffer),R=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let N=new TextDecoder("utf-8").decode(R.slice(o,o+a));S.log(N);let{ret:x,fd_obj:T}=r.fds[n].path_open(s,N,_,l,p,E);if(x!=0)return x;r.fds.push(T);let m=r.fds.length-1;return u.setUint32(w,m,!0),0}else return 8},path_readlink(n,s,o,a,_,l){let p=new DataView(r.inst.exports.memory.buffer),E=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let w=new TextDecoder("utf-8").decode(E.slice(s,s+o));S.log(w);let{ret:u,data:R}=r.fds[n].path_readlink(w);if(R!=null){let N=new TextEncoder().encode(R);if(N.length>_)return p.setUint32(l,0,!0),8;E.set(N,a),p.setUint32(l,N.length,!0)}return u}else return 8},path_remove_directory(n,s,o){let a=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let _=new TextDecoder("utf-8").decode(a.slice(s,s+o));return r.fds[n].path_remove_directory(_)}else return 8},path_rename(n,s,o,a,_,l){let p=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[n]!=null&&r.fds[a]!=null){let E=new TextDecoder("utf-8").decode(p.slice(s,s+o)),w=new TextDecoder("utf-8").decode(p.slice(_,_+l)),{ret:u,inode_obj:R}=r.fds[n].path_unlink(E);if(R==null)return u;if(u=r.fds[a].path_link(w,R,!0),u!=0&&r.fds[n].path_link(E,R,!0)!=0)throw"path_link should always return success when relinking an inode back to the original place";return u}else return 8},path_symlink(n,s,o,a,_){let l=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[o]!=null){let p=new TextDecoder("utf-8").decode(l.slice(n,n+s)),E=new TextDecoder("utf-8").decode(l.slice(a,a+_));return 58}else return 8},path_unlink_file(n,s,o){let a=new Uint8Array(r.inst.exports.memory.buffer);if(r.fds[n]!=null){let _=new TextDecoder("utf-8").decode(a.slice(s,s+o));return r.fds[n].path_unlink_file(_)}else return 8},poll_oneoff(n,s,o){throw"async io not supported"},proc_exit(n){throw new G(n)},proc_raise(n){throw"raised signal "+n},sched_yield(){},random_get(n,s){let o=new Uint8Array(r.inst.exports.memory.buffer);for(let a=0;a<s;a++)o[n+a]=Math.random()*256|0},sock_recv(n,s,o){throw"sockets not supported"},sock_send(n,s,o){throw"sockets not supported"},sock_shutdown(n,s){throw"sockets not supported"},sock_accept(n,s){throw"sockets not supported"}}}};var g=class{fd_allocate(t,e){return 58}fd_close(){return 0}fd_fdstat_get(){return{ret:58,fdstat:null}}fd_fdstat_set_flags(t){return 58}fd_fdstat_set_rights(t,e){return 58}fd_filestat_get(){return{ret:58,filestat:null}}fd_filestat_set_size(t){return 58}fd_filestat_set_times(t,e,i){return 58}fd_pread(t,e){return{ret:58,data:new Uint8Array}}fd_prestat_get(){return{ret:58,prestat:null}}fd_pwrite(t,e){return{ret:58,nwritten:0}}fd_read(t){return{ret:58,data:new Uint8Array}}fd_readdir_single(t){return{ret:58,dirent:null}}fd_seek(t,e){return{ret:58,offset:0n}}fd_sync(){return 0}fd_tell(){return{ret:58,offset:0n}}fd_write(t){return{ret:58,nwritten:0}}path_create_directory(t){return 58}path_filestat_get(t,e){return{ret:58,filestat:null}}path_filestat_set_times(t,e,i,c,r){return 58}path_link(t,e,i){return 58}path_unlink(t){return{ret:58,inode_obj:null}}path_lookup(t,e){return{ret:58,inode_obj:null}}path_open(t,e,i,c,r,n){return{ret:54,fd_obj:null}}path_readlink(t){return{ret:58,data:null}}path_remove_directory(t){return 58}path_rename(t,e,i){return 58}path_unlink_file(t){return 58}},D=class{};var M=class extends g{fd_allocate(t,e){if(!(this.file.size>t+e)){let i=new Uint8Array(Number(t+e));i.set(this.file.data,0),this.file.data=i}return 0}fd_fdstat_get(){return{ret:0,fdstat:new b(P,0)}}fd_filestat_set_size(t){if(this.file.size>t)this.file.data=new Uint8Array(this.file.data.buffer.slice(0,Number(t)));else{let e=new Uint8Array(Number(t));e.set(this.file.data,0),this.file.data=e}return 0}fd_read(t){let e=this.file.data.slice(Number(this.file_pos),Number(this.file_pos+BigInt(t)));return this.file_pos+=BigInt(e.length),{ret:0,data:e}}fd_pread(t,e){return{ret:0,data:this.file.data.slice(Number(e),Number(e+BigInt(t)))}}fd_seek(t,e){let i;switch(e){case st:i=t;break;case it:i=this.file_pos+t;break;case X:i=BigInt(this.file.data.byteLength)+t;break;default:return{ret:28,offset:0n}}return i<0?{ret:28,offset:0n}:(this.file_pos=i,{ret:0,offset:this.file_pos})}fd_tell(){return{ret:0,offset:this.file_pos}}fd_write(t){if(this.file.readonly)return{ret:8,nwritten:0};if(this.file_pos+BigInt(t.byteLength)>this.file.size){let e=this.file.data;this.file.data=new Uint8Array(Number(this.file_pos+BigInt(t.byteLength))),this.file.data.set(e)}return this.file.data.set(t,Number(this.file_pos)),this.file_pos+=BigInt(t.byteLength),{ret:0,nwritten:t.byteLength}}fd_pwrite(t,e){if(this.file.readonly)return{ret:8,nwritten:0};if(e+BigInt(t.byteLength)>this.file.size){let i=this.file.data;this.file.data=new Uint8Array(Number(e+BigInt(t.byteLength))),this.file.data.set(i)}return this.file.data.set(t,Number(e)),{ret:0,nwritten:t.byteLength}}fd_filestat_get(){return{ret:0,filestat:this.file.stat()}}constructor(t){super(),this.file_pos=0n,this.file=t}},z=class extends g{fd_seek(t,e){return{ret:8,offset:0n}}fd_tell(){return{ret:8,offset:0n}}fd_allocate(t,e){return 8}fd_fdstat_get(){return{ret:0,fdstat:new b(y,0)}}fd_readdir_single(t){if(S.enabled&&(S.log("readdir_single",t),S.log(t,this.dir.contents.keys())),t==0n)return{ret:0,dirent:new F(1n,".",y)};if(t==1n)return{ret:0,dirent:new F(2n,"..",y)};if(t>=BigInt(this.dir.contents.size)+2n)return{ret:0,dirent:null};let[e,i]=Array.from(this.dir.contents.entries())[Number(t-2n)];return{ret:0,dirent:new F(t+1n,e,i.stat().filetype)}}path_filestat_get(t,e){let{ret:i,path:c}=A.from(e);if(c==null)return{ret:i,filestat:null};let{ret:r,entry:n}=this.dir.get_entry_for_path(c);return n==null?{ret:r,filestat:null}:{ret:0,filestat:n.stat()}}path_lookup(t,e){let{ret:i,path:c}=A.from(t);if(c==null)return{ret:i,inode_obj:null};let{ret:r,entry:n}=this.dir.get_entry_for_path(c);return n==null?{ret:r,inode_obj:null}:{ret:0,inode_obj:n}}path_open(t,e,i,c,r,n){let{ret:s,path:o}=A.from(e);if(o==null)return{ret:s,fd_obj:null};let{ret:a,entry:_}=this.dir.get_entry_for_path(o);if(_==null){if(a!=44)return{ret:a,fd_obj:null};if((i&J)==J){let{ret:l,entry:p}=this.dir.create_entry_for_path(e,(i&B)==B);if(p==null)return{ret:l,fd_obj:null};_=p}else return{ret:44,fd_obj:null}}else if((i&ft)==ft)return{ret:20,fd_obj:null};return(i&B)==B&&_.stat().filetype!==y?{ret:54,fd_obj:null}:_.path_open(i,c,n)}path_create_directory(t){return this.path_open(0,t,J|B,0n,0n,0).ret}path_link(t,e,i){let{ret:c,path:r}=A.from(t);if(r==null)return c;if(r.is_dir)return 44;let{ret:n,parent_entry:s,filename:o,entry:a}=this.dir.get_parent_dir_and_entry_for_path(r,!0);if(s==null||o==null)return n;if(a!=null){let _=e.stat().filetype==y,l=a.stat().filetype==y;if(_&&l)if(i&&a instanceof U){if(a.contents.size!=0)return 55}else return 20;else{if(_&&!l)return 54;if(!_&&l)return 31;if(!(e.stat().filetype==P&&a.stat().filetype==P))return 20}}return!i&&e.stat().filetype==y?63:(s.contents.set(o,e),0)}path_unlink(t){let{ret:e,path:i}=A.from(t);if(i==null)return{ret:e,inode_obj:null};let{ret:c,parent_entry:r,filename:n,entry:s}=this.dir.get_parent_dir_and_entry_for_path(i,!0);return r==null||n==null?{ret:c,inode_obj:null}:s==null?{ret:44,inode_obj:null}:(r.contents.delete(n),{ret:0,inode_obj:s})}path_unlink_file(t){let{ret:e,path:i}=A.from(t);if(i==null)return e;let{ret:c,parent_entry:r,filename:n,entry:s}=this.dir.get_parent_dir_and_entry_for_path(i,!1);return r==null||n==null||s==null?c:s.stat().filetype===y?31:(r.contents.delete(n),0)}path_remove_directory(t){let{ret:e,path:i}=A.from(t);if(i==null)return e;let{ret:c,parent_entry:r,filename:n,entry:s}=this.dir.get_parent_dir_and_entry_for_path(i,!1);return r==null||n==null||s==null?c:!(s instanceof U)||s.stat().filetype!==y?54:s.contents.size!==0?55:r.contents.delete(n)?0:44}fd_filestat_get(){return{ret:0,filestat:this.dir.stat()}}fd_filestat_set_size(t){return 8}fd_read(t){return{ret:8,data:new Uint8Array}}fd_pread(t,e){return{ret:8,data:new Uint8Array}}fd_write(t){return{ret:8,nwritten:0}}fd_pwrite(t,e){return{ret:8,nwritten:0}}constructor(t){super(),this.dir=t}},K=class extends z{fd_prestat_get(){return{ret:0,prestat:$.dir(this.prestat_name)}}constructor(t,e){super(new U(e)),this.prestat_name=t}},k=class extends D{path_open(t,e,i){if(this.readonly&&(e&BigInt(64))==BigInt(64))return{ret:63,fd_obj:null};if((t&Q)==Q){if(this.readonly)return{ret:63,fd_obj:null};this.data=new Uint8Array([])}let c=new M(this);return i&at&&c.fd_seek(0n,X),{ret:0,fd_obj:c}}get size(){return BigInt(this.data.byteLength)}stat(){return new L(P,this.size)}constructor(t,e){super(),this.data=new Uint8Array(t),this.readonly=!!e?.readonly}},A=class wt{static from(t){let e=new wt;if(e.is_dir=t.endsWith("/"),t.startsWith("/"))return{ret:76,path:null};if(t.includes("\\0"))return{ret:28,path:null};for(let i of t.split("/"))if(!(i===""||i===".")){if(i===".."){if(e.parts.pop()==null)return{ret:76,path:null};continue}e.parts.push(i)}return{ret:0,path:e}}to_path_string(){let t=this.parts.join("/");return this.is_dir&&(t+="/"),t}constructor(){this.parts=[],this.is_dir=!1}},U=class f extends D{path_open(t,e,i){return{ret:0,fd_obj:new z(this)}}stat(){return new L(y,0n)}get_entry_for_path(t){let e=this;for(let i of t.parts){if(!(e instanceof f))return{ret:54,entry:null};let c=e.contents.get(i);if(c!==void 0)e=c;else return S.log(i),{ret:44,entry:null}}return t.is_dir&&e.stat().filetype!=y?{ret:54,entry:null}:{ret:0,entry:e}}get_parent_dir_and_entry_for_path(t,e){let i=t.parts.pop();if(i===void 0)return{ret:28,parent_entry:null,filename:null,entry:null};let{ret:c,entry:r}=this.get_entry_for_path(t);if(r==null)return{ret:c,parent_entry:null,filename:null,entry:null};if(!(r instanceof f))return{ret:54,parent_entry:null,filename:null,entry:null};let n=r.contents.get(i);return n===void 0?e?{ret:0,parent_entry:r,filename:i,entry:null}:{ret:44,parent_entry:null,filename:null,entry:null}:t.is_dir&&n.stat().filetype!=y?{ret:54,parent_entry:null,filename:null,entry:null}:{ret:0,parent_entry:r,filename:i,entry:n}}create_entry_for_path(t,e){let{ret:i,path:c}=A.from(t);if(c==null)return{ret:i,entry:null};let{ret:r,parent_entry:n,filename:s,entry:o}=this.get_parent_dir_and_entry_for_path(c,!0);if(n==null||s==null)return{ret:r,entry:null};if(o!=null)return{ret:20,entry:null};S.log("create",c);let a;return e?a=new f(new Map):a=new k(new ArrayBuffer(0)),n.contents.set(s,a),o=a,{ret:0,entry:o}}constructor(t){super(),t instanceof Array?this.contents=new Map(t):this.contents=t}},H=class f extends g{fd_filestat_get(){return{ret:0,filestat:new L(ot,BigInt(0))}}fd_fdstat_get(){let t=new b(ot,0);return t.fs_rights_base=BigInt(64),{ret:0,fdstat:t}}fd_write(t){return this.write(t),{ret:0,nwritten:t.byteLength}}static lineBuffered(t){let e=new TextDecoder("utf-8",{fatal:!1}),i="";return new f(c=>{i+=e.decode(c,{stream:!0});let r=i.split(`
`);for(let[n,s]of r.entries())n<r.length-1?t(s):i=s})}constructor(t){super(),this.write=t}};function ht(f){if(!(f instanceof Uint8Array))if(f instanceof ArrayBuffer)f=new Uint8Array(f);else if(f.buffer instanceof ArrayBuffer)f=new Uint8Array(f.buffer);else throw new Error("Argument must be a buffer source, like Uint8Array or ArrayBuffer");let t=new ct(f);At(t),bt(t);let e=[],i=[];for(;t.hasMoreBytes();){let c=t.readByte(),r=t.readUnsignedLEB128();switch(c){case 1:{let n=t.readUnsignedLEB128();for(let s=0;s<n;s++)e.push(Ct(t));break}case 2:{let n=t.readUnsignedLEB128();for(let s=0;s<n;s++){let o=t.readName(),a=t.readName(),_=t.readByte();switch(_){case 0:let l=t.readUnsignedLEB128();i.push({module:o,name:a,kind:"function",type:e[l]});break;case 1:i.push({module:o,name:a,kind:"table",type:Lt(t)});break;case 2:i.push({module:o,name:a,kind:"memory",type:Nt(t)});break;case 3:i.push({module:o,name:a,kind:"global",type:Dt(t)});break;default:throw new Error(`Unknown import descriptor type ${_}`)}}return i}default:{t.skipBytes(r);break}}}return[]}var ct=class{constructor(t){this.moduleBytes=t,this.offset=0,this.textDecoder=new TextDecoder("utf-8")}hasMoreBytes(){return this.offset<this.moduleBytes.length}readByte(){return this.moduleBytes[this.offset++]}skipBytes(t){this.offset+=t}readUnsignedLEB128(){let t=0,e=0,i;do i=this.readByte(),t|=(i&127)<<e,e+=7;while(i&128);return t}readName(){let t=this.readUnsignedLEB128(),e=this.moduleBytes.slice(this.offset,this.offset+t),i=this.textDecoder.decode(e);return this.offset+=t,i}assertBytes(t){let e=this.offset,i=t.length;for(let c=0;c<i;c++)if(this.moduleBytes[e+c]!==t[c])throw new Error(`Expected ${t} at offset ${e}`);this.offset+=i}};function At(f){let t=[0,97,115,109];f.assertBytes(t)}function bt(f){let t=[1,0,0,0];f.assertBytes(t)}function Lt(f){let t=f.readByte(),e;switch(t){case 112:e="funcref";break;case 111:e="externref";break;default:throw new Error(`Unknown table element type ${t}`)}let{minimum:i,maximum:c}=Nt(f);return c?{element:e,minimum:i,maximum:c}:{element:e,minimum:i}}function Nt(f){let t=f.readByte(),e=f.readUnsignedLEB128(),i=t&1,c=(t&2)!==0,n=(t&4)!==0?"i64":"i32";if(i){let s=f.readUnsignedLEB128();return{minimum:e,shared:c,index:n,maximum:s}}else return{minimum:e,shared:c,index:n}}function Dt(f){let t=lt(f),e=f.readByte()===1;return{value:t,mutable:e}}function lt(f){let t=f.readByte();switch(t){case 127:return"i32";case 126:return"i64";case 125:return"f32";case 124:return"f64";case 112:return"funcref";case 111:return"externref";case 123:return"v128";default:throw new Error(`Unknown value type ${t}`)}}function Ct(f){let t=f.readByte();if(t!==96)throw new Error(`Expected function type form 0x60, got ${t}`);let e=[],i=f.readUnsignedLEB128();for(let n=0;n<i;n++)e.push(lt(f));let c=[],r=f.readUnsignedLEB128();for(let n=0;n<r;n++)c.push(lt(f));return{parameters:e,results:c}}var Ut=(()=>{let f=new Uint8Array([0,97,115,109,1,0,0,0,2,6,1,0,0,2,0,1]),t=new WebAssembly.Module(f);return typeof WebAssembly.Module.imports(t)[0].type=="object"})();function Ot(f){if(Ut)return f;let t={};for(let r in Object.getOwnPropertyDescriptors(f))t[r]=f[r];let e=Symbol("polyfilledImportsSymbol"),i=(r,n)=>{r[e]=ht(n)},c=t.Module=function(r){let n=new f.Module(r);return i(n,r),Object.setPrototypeOf(n,c.prototype),n};return Object.setPrototypeOf(c.prototype,f.Module.prototype),t.compile=async r=>{let n=await f.compile(r);return i(n,r),n},f.compileStreaming&&(t.compileStreaming=async r=>{let n=await r,s=n.clone(),o=await f.compileStreaming(n);return i(o,new Uint8Array(await s.arrayBuffer())),o}),c.imports=r=>{let n=r[e];return n||f.Module.imports(r)},t}var Y=Ot(globalThis.WebAssembly),et=class{constructor(t){this.decoder=new TextDecoder("utf-8",{fatal:!1}),this.buffer="",this.onLine=t}decoder;buffer;onLine;send(t){this.buffer+=this.decoder.decode(t,{stream:!0});let e=this.buffer.split(`
`);for(let i=0;i<e.length-1;i++)this.onLine(e[i]);this.buffer=e[e.length-1]}};async function mt(f,t){let e=Ft(f),i=e.swift;if(!i&&e.SwiftRuntime){let R=!1;for(let N of Y.Module.imports(e.module))if(N.module==="env"&&N.name==="memory"&&N.kind==="memory"){R=!0;break}i=new e.SwiftRuntime({sharedMemory:R})}let c;e.onStdoutLine!=null&&(c=new et(e.onStdoutLine));let r=new H(R=>{e.onStdout?.call(void 0,R),c?.send(R)}),n;e.onStderrLine!=null&&(n=new et(e.onStderrLine));let s=new H(R=>{e.onStderr?.call(void 0,R),n?.send(R)}),o=e.args||[],a=e.rootFs||new Map,_=[new M(new k([])),r,s,new K("/",a)],l=e.env?Object.entries(e.env).map(([R,N])=>`${R}=${N}`):[],p=new _t(o,l,_,{debug:!1}),w=((R,N)=>{let x={wasi_snapshot_preview1:p.wasiImport};if(i&&(x.javascript_kit=i.wasmImports),R)for(let T in R){x[T]||(x[T]={});for(let m in R[T])x[T][m]=R[T][m]}for(let T of Y.Module.imports(N)){let m=T;if(x[m.module]||(x[m.module]={}),!x[m.module][m.name]){if(m.kind=="function")x[m.module][m.name]=()=>{throw new Error(`Imported function ${m.module}.${m.name} not implemented`)};else if(m.kind=="memory"&&m.module=="env"&&m.name=="memory"){let nt=m.type,xt={initial:nt.minimum,maximum:nt.maximum,shared:nt.shared};x[m.module][m.name]=new Y.Memory(xt)}}}return x})(t,e.module),u=await Y.instantiate(e.module,w);return i&&u.exports.swjs_library_version&&i.setInstance(u),typeof u.exports._start=="function"?p.start(u):typeof u.exports._initialize=="function"&&(p.initialize(u),i&&i.main?i.main():typeof u.exports.main=="function"?u.exports.main():typeof u.exports.__main_argc_argv=="function"&&u.exports.__main_argc_argv(0,0)),{instance:u,rootFs:a}}function Ft(f){return f.args==null&&(f.args=["main.wasm"]),typeof process<"u"&&process.release.name==="node"?(f.onStdout||(f.onStdout=i=>process.stdout.write(i)),f.onStderr||(f.onStderr=i=>process.stderr.write(i))):typeof window<"u"&&(f.onStdoutLine||(f.onStdoutLine=i=>console.log(i)),f.onStderrLine||(f.onStderrLine=i=>console.warn(i))),f}var Pt=async()=>{let f=await fetch("\(wasm)"),t;try{let{SwiftRuntime:e}=await import("./JavaScriptKit_JavaScriptKit.resources/Runtime/index.mjs");t=e}catch{}await mt({module:await Y.compileStreaming(f),onStdoutLine(e){console.log(e)},onStderrLine(e){console.error(e)},SwiftRuntime:t})};async function Bt(){await Pt()}Bt();
""" }
}

