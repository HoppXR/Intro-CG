using UnityEngine;

public class DecalOnOff : MonoBehaviour
{
    private static readonly int ShowDecal = Shader.PropertyToID("_ShowDecal");
    private Material _mat;
    private bool _showDecal;
    
    void Start()
    {
        _mat = GetComponent<Renderer>().sharedMaterial;
    }

    private void OnMouseDown()
    {
        _showDecal = !_showDecal;
        if (_showDecal)
            _mat.SetFloat(ShowDecal, 1);
        else
            _mat.SetFloat(ShowDecal, 0);
    }
}
