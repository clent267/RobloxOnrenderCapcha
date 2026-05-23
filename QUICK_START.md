# 🚀 RENDER DEPLOYMENT - QUICK REFERENCE

## THE 3-STEP DEPLOYMENT

### Step 1: Update Your Files
```bash
cd funcapt_think
cp Arkoselabs_RenderReady.php app/controller/Arkoselabs.php
cp Dockerfile.thinkphp Dockerfile
cp render.yaml .
```

### Step 2: Push to GitHub
```bash
git add .
git commit -m "ThinkPHP FunCaptcha - Render Ready (NO rate limits)"
git push origin main
```

### Step 3: Deploy on Render
1. Go to https://render.com/dashboard
2. Click **New** → **Web Service**
3. Connect GitHub repo
4. Set name: `funcaptcha-thinkphp`
5. Set environment: **Docker**
6. Set plan: **Standard** ($7/month)
7. Click **Deploy**

**Done in ~2 minutes!** ✅

---

## RENDER RUN COMMAND (What Gets Executed)

Render automatically executes from Dockerfile:
```bash
docker build -t funcapt-thinkphp:latest .
docker run -p 8080:8080 funcapt-thinkphp:latest

# Result: https://funcaptcha-thinkphp.onrender.com 🎉
```

**You don't need to run this - Render handles it all!**

---

## TEST YOUR ENDPOINTS

After deployment (wait 2-3 minutes):

```bash
# Health check
curl https://funcaptcha-thinkphp.onrender.com/arkoselabs/health

# Should return:
# {"status":"ok","timestamp":"2026-05-24 12:30:00","service":"FunCaptcha"}
```

---

## API ENDPOINTS

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/arkoselabs/health` | Health check |
| POST | `/arkoselabs/gfct` | Get challenge |
| POST | `/arkoselabs/fcca` | Submit answer |
| GET | `/arkoselabs/init_load` | Initialize |
| GET | `/arkoselabs/rtigimage` | Get image |
| POST | `/arkoselabs/pkeytoken` | Get token |

---

## FILES YOU RECEIVED

✅ **RENDER_RUN_COMMAND.md** - Complete deployment guide (READ THIS!)
✅ **RENDER_DEPLOY_GUIDE.md** - Detailed reference
✅ **Arkoselabs_RenderReady.php** - Updated controller (NO rate limits)
✅ **Dockerfile.thinkphp** - Docker config for Render
✅ **render.yaml** - Automatic deployment config
✅ **test-render.sh** - Local testing script

---

## KEY CHANGES

✅ **NO RATE LIMITING** - Completely removed
✅ **Health Endpoint** - `/arkoselabs/health` for monitoring
✅ **Alpine Docker** - Lightweight & fast
✅ **Proxy Support** - Optional (disabled by default)
✅ **Auto-Deploy** - Git push to live

---

## MONITORING

**After deployment, check:**

1. **Health Check** → `/arkoselabs/health` returns `{"status":"ok"}`
2. **Logs** → Render Dashboard → Logs tab (watch for errors)
3. **Metrics** → Render Dashboard → Metrics tab (CPU/Memory)
4. **Auto-Deploy** → Next push auto-deploys in 2-3 minutes

---

## ENABLE PROXIES (Optional)

Edit `app/controller/Arkoselabs.php` line 48:
```php
$use_proxy = true;  // Change from false to true
$proxies = [
    "socks5://your-proxy:1080",
    "http://proxy2:8080",
];
```

Then:
```bash
git add .
git commit -m "Enable proxies"
git push origin main
```

---

## TROUBLESHOOTING

| Problem | Solution |
|---------|----------|
| Build fails | Check Render logs, verify file names |
| Health check fails | Wait 5-10 seconds, rebuild manually |
| 404 errors | Verify routing, check if files pushed |
| Slow response | Upgrade plan or check metrics |

---

## PERFORMANCE

**Standard Plan** ($7/month) - Recommended
- 100-200 RPS
- 50-100ms latency
- 256-512MB RAM

**Pro Plan** ($50/month) - High traffic
- 500+ RPS
- 30-50ms latency
- 512MB-2GB RAM

---

## REMEMBER

✅ Replace `Arkoselabs.php` with `Arkoselabs_RenderReady.php`
✅ Use `Dockerfile.thinkphp` (or rename to `Dockerfile`)
✅ Include `render.yaml` in repo root
✅ Push to GitHub main branch
✅ Test health endpoint after deploy

---

**Your server is ready to deploy! 🚀**

Questions? See **RENDER_DEPLOY_GUIDE.md** for complete details.
