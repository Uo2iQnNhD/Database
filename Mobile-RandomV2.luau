-- 1. Masukkan semua URL loading screen ke dalam tabel
local daftarScript = {
    "https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/m4JymrG3-LoadingPH-V2.luau",
    "https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/LgMrbYxN-LoadingMobile.luau"
}

-- 2. Cek apakah ada eksekusi sebelumnya menggunakan _G
-- _G berfungsi untuk mengingat data antar eksekusi di sesi yang sama
local indexTerakhir = _G.LastExecutedIndex
local indexSekarang

if not indexTerakhir then
    -- Jika ini pertama kalinya dieksekusi, pilih secara acak
    indexSekarang = math.random(1, #daftarScript)
else
    -- Jika sudah pernah dieksekusi, ganti ke script selanjutnya (bergiliran)
    -- Rumus modulo (%) otomatis akan memutar ulang ke index 1 jika sudah sampai akhir
    indexSekarang = (indexTerakhir % #daftarScript) + 1
end

-- 3. Simpan index yang sedang dieksekusi saat ini agar diingat untuk eksekusi berikutnya
_G.LastExecutedIndex = indexSekarang

-- 4. Ambil URL dan eksekusi
local urlTerpilih = daftarScript[indexSekarang]
loadstring(game:HttpGet(urlTerpilih))()
